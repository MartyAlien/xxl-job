#!/bin/sh

#jar包名称
JAR_NAME=xxl-job-admin.jar

start(){
        nohup java -jar -Xmx2048m -Xms1024m -XX:+UseAdaptiveSizePolicy -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8 $1 > /dev/null 2>&1 &
}
stop(){
        pid=`ps -ef | grep java | grep ${JAR_NAME}  | grep -v grep| awk -F '     ' '{print $2}'`
        arrpid=(${pid})
        len=${#arrpid[@]}
        if [ $len -eq 1 ];then
                kill -9 $pid
                echo "stop $pid"
        else
                echo '*-*-*  stop opms ERROR  *-*-*-*-*-'
                exit 0
        fi
}
check(){
        if [ -z $1 ];then
                echo "*-*-*-*-*-请输入要启动的jar文件名*-*-*-*-*-*"
                exit 0
        fi

        if [ ! -f "$1" ]
        then
                echo -e "\n......文件 $1 不存在......\n"
                exit 2
        fi

        if [[ $1 != *.jar ]]
                then
                echo -e "\n......输入文件类型有误，请重新输入......\n"
                exit 2
        fi

}
case $1 in
        start)
                echo "*-*-*-*-*-*-* 准备启动  *-*-*-*-*-*-*-*"
                check $2
                start $2
                echo "*-*-*-*-*-*-* 启动完成  *-*-*-*-*-*-*-*"
                ;;
        stop)
                echo "*-*-*-*-*-*-* 准备停止 *-*-*-*-*-*-*-*-*"
        #       check $2
                stop
                echo "*-*-*-*-*-*-* 停止完成 *-*-*-*-*-*-*-*-*-*"
                ;;
        restart)
                echo "*-*-*-*-*-*-* 准备重启 *-*-*-*-*-*-*-*"
                check $2
                stop
                start $2
                echo "*-*-*-*-*-*-* 重启完成 *-*-*-*-*-*-*-*"
                ;;
        *)
                echo "*-*-*-*-*-*-* 输入参数有误 *-*-*-*-*-*-* "
                ;;
esac


