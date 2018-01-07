Plugin.create(:"mikutter-wunderlist") {
  # 一定時間ごとに処理を行う
  defdsl(:timer) { |second, &proc|
    proc.()

    Reserver.new(second) {
      timer(second, &proc)
    }
  }
}
