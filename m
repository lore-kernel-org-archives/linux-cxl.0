Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D47399347
	for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327910; cv=none; b=jMHH5YPAV/xc0WD8DIjF5NZxme605G9+NuK4GgUecra0yUdcU6OtfOpqL6LT19tZciykVvO8ltWti2Q+R0gNaFv9+X0EMVhXksFHFYo02AGvgdkZW6uXPbAfV3KB08cjv7YEdWSE/WIoTE87wQeFEzoL/N/K5odEkDrW8owWRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327910; c=relaxed/simple;
	bh=+2aFHUSGg5NaIDd3/YxMv/LxE90w9nNW8znYb5WStZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbx3sFuxHWLEzQp9x1JmA55VxhF0xRd2ETB1pOUeNbTwjvcGZNRbQw3HjDZHhIh4227bIpejBjxqoE2OiTHyFs8wgN++tjEL+ESWjXXbCTjbbLe0x1Y4hiBI75RFvANRCAdJmL9zzAjMiRk4AromscoLam7bCeariCBW4XDS9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dytlJpFP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dytlJpFP"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-464ba2bb3aeso686127b6e.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773327908; x=1773932708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2aFHUSGg5NaIDd3/YxMv/LxE90w9nNW8znYb5WStZ4=;
        b=dytlJpFPawNkOwVAPLhr/Wd5xvdsrw3VUE/aCp6t2L51OkyS3ftjkjOqx5sLrLNwdy
         66ArPhhCQPSJt2zt5u3D8PXEcpx0Pyl1gO2zxvvvpGYy0jzA/0V9ZhxwsGSYHR4W6i2Z
         zqvF1p56z6faowW+z371YUfWZjiV++b66dOOMhAjKQoDZvbmehIhd95ENKhawoD4aI3w
         CBBA2FBhd9gX/QVG2C3UduSpHJZG4dcTg3pLAB11SV5mxFWeX/b3+tevThUBnDExwmKH
         xxctZ573v9AVPLpXCNYxo9j/yxuAEt+N7DYkprig85NO54oZi79z8a3HlZ1iXaI+CrxF
         wJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327908; x=1773932708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2aFHUSGg5NaIDd3/YxMv/LxE90w9nNW8znYb5WStZ4=;
        b=Me1K7qtWCI/BDPUVAd7Hlxtd9qm/T5YxVsWb7ojuIkXEp+f9HtmCUojJiS92ONDi8K
         HwU820ISS8QBKl4air0t4Wv6URS+wM9C9Scg09gweiRJq+lBkbGYPzdzyp0JxG9WSIQC
         VtsXu371B+4bREdx7Lu1C1K+09M7Yu8v0ElbZ9Yc75O3rR/VhJFPc4RK+wwCa8i59FgV
         rsS1oPGYMc7x9tOh4JT+ezR62FX1nWvxnbYDn7TRcDHcguP8VEx/VN2LnqPgu4ATeNcj
         b7MzEzlRavvsYpCCNBIYHODpeNwvJKC6yuqwRKlwfoUb34zJVrLNOGJRq41b7HVzetBG
         2s2A==
X-Forwarded-Encrypted: i=1; AJvYcCUykwKid4IX/hav58qVn8ulAJApbcoteuFEQOZ5CJ9kLmUnN1aCLhQVMpJA0xFzD4RX8KPOqq3vJQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCqEvfisB0JJge4h6RghqppV6ICH1uDOwFx+1qN9yDgJl05BT
	rlnc9rpJ/JR5FXavQXbIXTxmwTR4Nf51p9wyXUnBW1o6rDk/QsPGFIBu
X-Gm-Gg: ATEYQzxqukdSmZtiTnxOSnWYqGXU8a3oJQ63SdpH56R7xe8dP389jN7dCOglDcQ3ZGf
	dfeCluN/AlJxac9CyOOBKi4GaB9YVmYPCCeSFM/NSNEotAaXPJERgvuSnFgvp5rdtcnOo8j9cmT
	9NWiZvacu6GclcjcHfalrm0OomRfhjcCKLyX+zEggTL9DT5jrNm9X5mMjKk2p1p4gZgh2JMyR7M
	oCrMJ5Cwaz7Mf0LCzNa9kadUGaj4I45GMyzZbd8GyXyHJW2lPIdf4T9GAWkEDSNar4l7BBzIdA4
	N4sPyeHzFvY6GWsu6l+sHot8zXUXGU2ek0vNy4mbXbK80wnwGAOa6yrrewg1gfWSVK7MMBOsE0G
	6tloGOwG0SR9Onv9ZOwvnz0TmB2HbRRk/rTXdfdLyyyicbThtVBkt9QzYIyKK6q4umqnaPq/gzw
	vJKcwlL0XL8N9dfO8KCsu6bA==
X-Received: by 2002:a05:6808:4f1f:b0:45e:fd68:3de7 with SMTP id 5614622812f47-467431d1f7dmr1968478b6e.24.1773327908252;
        Thu, 12 Mar 2026 08:05:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342ef6fesm3095232b6e.14.2026.03.12.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:07 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: YeeLi <seven.yi.lee@gmail.com>,
	akpm@linux-foundation.org,
	david@kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node bandwidth
Date: Thu, 12 Mar 2026 08:05:03 -0700
Message-ID: <20260312150505.1502645-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312150022.1373486-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Mar 2026 08:00:21 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Thu, 12 Mar 2026 17:12:07 +0800 YeeLi <seven.yi.lee@gmail.com> wrote:

Cc-ing Gregory's REAL address, this time... sorry for the noise!
