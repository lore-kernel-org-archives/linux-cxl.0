Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611253;
	b=hT30thOWXxCBkB58eIuCtYdG+wdnO6OnCEA6emv21rdBULPENwDYIjEusquCQnCHeABt
	 e+3EQj2m/c2h7Yd+gouRcPYhkJMf4ZORy37B4HHVBTT86p2YdbRBcc6EQZxuIk/gXnm1f
	 XYeWALexxBwkjo0MuHVdm6zHSmUWVQOKCC/6JH9GxkLGqNA9FMS4fYoYEjBJ+YWbG8D6S
	 Rknq2FQ1JyW9mM420chPQqMHWrOIaxv8XiwcMmoTCm98/eu8JVjHNgtHAD2lqm2estuUx
	 l4hDzz2Xcp+WNivj326f2rVx21O97DFqJItybfI891tmv+KlY+JafAzkz2J0pK9ZYIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oqDE8X8d+SNdchG37m3I0xn7gitvbo9INEy7a8wSuJo=;
	b=eaT2IyuSKRLpPhZm3iS2wO4NED5bl7TSx4gPLL3AUqbJoXeBjaUYgscmpM5osx/MbPYz
	 W5HM/iVJV9Oswn16e77JpIdY1L+SwcYFhxXWOETXSQGC9wgVOwzbOcLcCuMhwFObKin+A
	 xQ+u8rt04PAMxVlmUQrEqorNOO5kSc7kMpv/6+NZu45IW3q1CTgfgk3poBGgxGoWyPE4O
	 hhdcUftndMZLk5uoFXUOPhV2E7gwJibefLcHVySxpL2rJIOzJTv6DJMeLmraghqnI0/mY
	 Uwtky2YikZraYmKbT7D2WmCeJGpjn8T41D9kDjfQc89+uWsH8Q9Ad3WP6VsrEQbopqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7dxQvho;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77204606A6A8
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77204606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7dxQvho
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso3836130a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795611253; x=1796216053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oqDE8X8d+SNdchG37m3I0xn7gitvbo9INEy7a8wSuJo=;
        b=c7dxQvhoD/U0l9DHjCDDjSOOdIQYP9sh4Sh+xyLlp99/DjuvXTylhvkFM9Oqteg7ia
         VbVZd1VAqnDivseBVcTgKWpKEZq6uO9ByH26wKJmn6XhjrIEgSCuKCYKnHfWVLLKjLNj
         K3o+vBxG0yRwmigUlSsXGv1Wetxnee6iptSxg0HI0HhugVEFAXtGKG1GjmqCiZ6Jw7ps
         cWkhuIbAsmWQqXjhWO5TXg0M1tKFwSk18OWHJTqw8vmgMjeIRWPYa8diWBj+xIq4OTnj
         9smGzQCRJhsDmQPrwUtZhSTFDyRzR9GiP/27Bt23z5469DNBVQAEjzdOt7lwIkQBwu/b
         uGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611253; x=1796216053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oqDE8X8d+SNdchG37m3I0xn7gitvbo9INEy7a8wSuJo=;
        b=JZHkQHM0IcYD1Z7lkA4K69EGYFV8mZmBbtp6ZT6foROuKy8gKsjQ9ZX6eJJpYRraZc
         vuBPVcZ09Uno1WXoIpsqlBwOUB7YOyrOU1D5yVr8tE27aQVGDAZVmKwBPT+vX2M4eFR2
         1iyrZ3kltPQJwB3ENAY1DZfF6e4QAoBWflVHXdflTUmAjsGNIgY8ztlQ29fXqaV0pg9I
         3ObKyM6jYMQAQrQpyg8lit9eRypjH6YCL7ci9omF/+8QeZeDgBotN/9On46NtxZcj/qA
         H6UPlyqyXwNwT9NGL+rSwOnooKDmh/6AdHGzSZKaBVLAW8rWbONmOhxcLXVb35bSmtQt
         aRNQ==
X-Gm-Message-State: APuU4Z9livdj/BV2P8Bi10BSSc/gxYNPVJ2N5BAad37hbK6i9c797eK7
	r76UvKqYTd62q7HeTffk7vad93Uc/asopqwaPyd9KobnOLK4pvZHEJZughz8Ukug
X-Gm-Gg: AZFdTZfJDaMdt8cvUzHV/oNkAbBQgNe4AWFAMIzatKOeRdyYZlEcm0ud/zWq/pH7HK6
	6TNpusI0zPtxC/ojGzL3kR7uzzOsB82iSZqPz6RYmHiTrbtTr21Kp8x2Iy2DlEP/BQA1LtN4mSK
	M3SyZg+8Bugd4q9ryTkgdLWIfvhSl5SqGJBNwhilfKqq8YjkmyqCbAHDv1NzfkVI9052zJis56e
	wCOJGJM9skRzm5hR2zzVqBaztR4jm2xaWgZdbG39FiuCE40FHsMONHezGuAQi6H0jTK/687dzKl
	NPan6wuRP7/jHf72V/LS9Lk9lT3gutWGtyP/oaQyTtwXORjAqe/sVGwwI/CLwbatl4BjJn4MldV
	8vlnXUJJetBhodSCxxU8OClqRuXAsQYeIhZPa33UYHbw+Z/hMWx6qlojtJQ7RK1gLbk7bNW7CHI
	tJd6+EVs1Xm7m4ZeLt+Gn3YevGQlFF5K6iz0Akq3xugcpEMYAZZ0MOK7K9OvoGJa9fpfWIgEmXc
	Z3kprwf4OKNUUG8AeUZKD2g9XWX4viJmyAQqpYDn46bAKLWmCqeID7wXtD3K6RvJHjSd5uxoe5V
	kKwYay98Dgko0Ux672RCRVlMOF/DyG+idRM4gckp/+G9/j3MmlDaOCnnxX2gDKgi
X-Received: by 2002:a05:6a20:430a:b0:3f9:bcb9:30f1 with SMTP id adf61e73a8af0-4014c3508ccmr19863846637.44.1795611252740;
        Wed, 25 Nov 2026 04:54:12 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1d71dsm9013579b3a.53.2026.11.25.04.54.11
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:54:12 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Date: Wed, 25 Nov 2026 21:53:43 +0900
Message-Id: <20261125125343.3585547-1-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125124358.3583223-1-unsung0317@gmail.com>
References: <20261125124358.3583223-1-unsung0317@gmail.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the noise. A mistake in my test sends put six copies of this
cover letter on the list on their own (12:10 to 12:42 UTC), without the
patches, and some with older text. Please ignore those; this thread,
with patches 1-4, is the series.

Unsung
