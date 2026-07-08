@ComponentV2
export struct StarRating {
  @Param rating: number = 0
  @Param total: number = 5
  @Param readonly: boolean = true
  @Event onRate: (value: number) => void = (value: number) => {}

  build() {
    Row() {
      ForEach([1, 2, 3, 4, 5], (star: number) => {
        Text(star <= this.rating ? '★' : '☆')
          .fontSize(18)
          .fontColor(star <= this.rating ? '#FF6600' : '#DDD')
          .onClick(() => {
            if (!this.readonly) {
              this.onRate(star)
            }
          })
      })
    }
  }
}
