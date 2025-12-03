Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215B158535
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796611; cv=none; b=K3RvHI92lzhfeq5Nq9a0oQi6C6Fcmj4Urzg5kbVAj+0vXmetV8exNbuhsdDBTvOohAzZz8CTL0h1nSH5CICfQXwNYcvKRHMHJdPTXzGFf+j+a+zxUl6kGlVzEru4PrDnTmIRcJep0Kd86I1ArIrh9az5mP7v7zYrYjMk2RNpWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796611; c=relaxed/simple;
	bh=NLS4qY7amc99wZpR+qNVDskOh4GtX0r5CtMdxo9H7lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=so+kOonWukFn8frspGScgyFKf+iVlzw28O1lMhP9UPd47Tidz5AizZdC1gK1cMvJ3+gWjXw+fT9C+MaQxriVsHpovg094Q+fIiSlm1aRkl616IG1gZLri6LPWnxQ6p1sii0iBqML4SqNsl6aXZ/C8PcUEC6XaR4yJtW1tB3jWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEPhRqBQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEPhRqBQ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso117481a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764796609; x=1765401409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqqt8VHq5+/d/91spKx9LIJdkD7MSG+xWaf5hIr/r9A=;
        b=JEPhRqBQhIl0BxZKdDsTRF17nh+ovHdsy8wEelksSt2ZJ//oCbcTtehO74AjAxqxrU
         ssb5qu+yqhSLUb8XYsEWR/sfMXMebQNscl8Zur35c4AHmFz/cLJbG8QR1jakdP4qr5Ra
         38NMTomQ5DQ0ejO7km4fEDBn3Cybf6hcXvaJkN/9w9O4NzHdnsv619mZXImWxeMkNtsG
         Dl0osMucDBaMmkk2Kz2nU+AHwPaeZMsyMq7niMr85lnPDurZO6CtA103J4APWJzWk0yp
         YAu13+E3RptcyofQ0jv5PU+FkE9pmVDIabQKk38Wz+lK5FjiuLTAIzFQcQoDmytbmpI+
         JQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764796609; x=1765401409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqqt8VHq5+/d/91spKx9LIJdkD7MSG+xWaf5hIr/r9A=;
        b=FVvmZ+SLUol1iD3xczYzLzY+RAnhvqYNpkXxhmKx/sMSIND3+2EBEK/y96vhOrgq6A
         Qe0AiHxDrYRBHzMw+yiHtbvcI1ZIOkzXhNkUJCr39M7mWsnMozH9JD2w+3hb/y6PrRCQ
         313qT00rQ9nLSrKY73DpY1lH5OD1GK2ulqRruni0AuOoJcueO8GVTEK/Qf/V6lBrwZ8x
         Nv7QfHnwahEPcJVfboPQ3rXtjHA5zfjRZuGq3iqPBSw26vSWRFGVYtW/kSs4UEH0XzDm
         ZVZPLi44FbNie96a1jis8OHhsryiggAIwCFrWKafutySyONcPGEZINEmNLIiqSte9JV1
         x8Fw==
X-Gm-Message-State: AOJu0YzqYAMbwJgO7QrZCPLJY0rfVu83UQB7EQWN0nE38ecQ6B2BcD9H
	CSYJ+BON9CJ1GR19jFVfN2iTl7GEbjBUSBVtERc/WnNRUElbL35OoHVAbSC/0g==
X-Gm-Gg: ASbGncv3ZrrrDQgYIjJXP5ShoUeuPMOtBHhKP2BXXJekOZZtAT+l2akqW2Z9eHmhUIW
	KCaI/0Pw+5layUfzCrMhfK22e66pEy+MQ3ot+4lV7qreImSiykuzOvyn/QzWj7sPrCIDHgDZkk1
	hu8nDSX3oJ8xQ7/vy34SudYhF5vKr5iwVAmc8e+plFOBOdvYW3JSLd82t9HWvT/uJOVjdLLP/EO
	p/Xuj4agiqw584vBmYEpfS6hJUt+YW2EAZZU1PG9fD5G7O42Hp2GbTFVU+m1gFUKfinZKCu+YT+
	ZWBPxx1gZOWPScrgCdqs9wvKX6G31FDC7HA67Api88WmSa9mFs6Dx1lmv+qXaEBkjhFfDSBZY52
	8OlqDXXcKU3eGvein9Lta8mb+51Ft/4zuBDncOIOxUzoTcAKcVvC7piXW/ZnH94uJvoHWYxSp1g
	oDI8SeJKTQB1DgMNsegkFYYggQPIFpSwHmQA0BsrkmCvc=
X-Google-Smtp-Source: AGHT+IGO90CMoFNJQZx7v6b+L91eU3ZStMVaa3Rd9ifesxv80CT2G6ZGEwfm6KoY0ftpUNd5GLf4hA==
X-Received: by 2002:a05:693c:2285:b0:2a7:760:2b61 with SMTP id 5a478bee46e88-2ab92da0fe1mr2585666eec.3.1764796609309;
        Wed, 03 Dec 2025 13:16:49 -0800 (PST)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm67419981eec.0.2025.12.03.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 13:16:48 -0800 (PST)
From: anisa.su887@gmail.com
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	Anisa Su <anisa.su@samsung.com>
Subject: [RFC NDCTL PATCH 0/2] Support for Multiple DC Regions
Date: Wed,  3 Dec 2025 21:15:23 +0000
Message-ID: <20251203211642.1104918-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

This patchset introduces support for up to 8 DC regions. It is based on the     
latest branch published to Ira's repo:                                          
https://github.com/weiny2/ndctl/tree/dcd-region3-2025-04-13                     
It corresponds to and was used to test the patchset introducing support for     
multiple regions in the kernel:                                                 
https://lore.kernel.org/linux-cxl/20251203203540.1091827-1-anisa.su887@gmail.com/T/#t

Fan Ni (2):
  rename RAM_A to RAM_0
  cxl: extend DCD related features to support up to 8 regions

 Documentation/cxl/lib/libcxl.txt | 13 +++--
 cxl/json.c                       | 46 +++++++++++------
 cxl/lib/libcxl.c                 | 84 +++++++++++++++++++++-----------
 cxl/lib/libcxl.sym               |  9 ++--
 cxl/lib/private.h                |  6 +--
 cxl/libcxl.h                     | 48 ++++++++++++++----
 cxl/memdev.c                     |  3 +-
 cxl/region.c                     | 27 +++++-----
 test/cxl-dcd.sh                  |  4 +-
 9 files changed, 164 insertions(+), 76 deletions(-)

-- 
2.51.0

