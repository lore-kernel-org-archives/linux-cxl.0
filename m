Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4433D96D
	for <linux-cxl@vger.kernel.org>; Sun, 19 May 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128895; cv=none; b=lswg2YKFxWnurwaslRzFZthgEgc71f0IfgJ8zxQIZWUSunhgi4ZOrJlpzTS4WTwUA26OZqtSKcnwh/sIxzgf5vNYstvAfjcmulNllkcchDrmfkfKUBSwc3D5vj5ztTpG/0EqhYbK2mWEJu6DgvJYbo10Tp85Lklj7CLO9LqVEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128895; c=relaxed/simple;
	bh=mCQxRvoc8Lkm+raSdQxJlzP6RlVwoNfKWJzoIL7LZf0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=V5ksrwnfa89mvvSIRTlvzT9+9Y5qi/D6XPzjGp/D2Xj/nviwyCxdzlaI0afhq5n2l58/Y/QkDzF3VdKhxXS4db8EyTcSk+CumVjycF4Ah7xQaZcKlBCPBfibhOY3HcdpuP1/GcFiOruG+o+GOy09EhgiIOxTexOwiB2o66hRkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=eR0d/m3n; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="eR0d/m3n"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so1873860e87.0
        for <linux-cxl@vger.kernel.org>; Sun, 19 May 2024 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1716128892; x=1716733692; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktJNLvqg4qgzKfjmCQh9z1qoXtGO9rBsHSZfGew+izw=;
        b=eR0d/m3ns5I70+Zs5SM+M+ZrVYdT2NHE+ulVFk/Aw8tJpCQC0bqMsJ4xPwWXIypKVu
         yNZt/fqb5fexTNTkrKPZGGkKGXoAZqtvE0U6W9W41PG16OvDjov1YFtgdOT7eVDrTQcg
         8Pj2YpIAKEg3C9IvcvhDvUtc7YF8/yNfc0QwAGpjg3xn5ilac0fhaXbds2Pfacs+MW+T
         rmTGtpq5i+B7cuETYo0tT7DAqlul2fxjV59rAPwty3uANj3BTWjfPR0elAqdghSB8dVI
         hl461Aymn6tcdPj6tfHHaz84ZnW4NSZYkwWKqHhB4VLNqMu2b2d766f8OsXwzU9jxZ0B
         wJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716128892; x=1716733692;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktJNLvqg4qgzKfjmCQh9z1qoXtGO9rBsHSZfGew+izw=;
        b=WRyCf+keX3G6vHkahgA6uhVHzBHC5MwCKP3Sf+qZxvYqtBFwpTcrzbhs+JlMbJ2ZXB
         4GrkhtDOK2IMeOdhBA8oCsqJOj79/P44eGOV88cGe671JMD8vicOLHtpF6ya3i4WHc80
         GIAzM8HH7Pi6Eu+6Qfl0s6WLfX0L0YRSshFqoZA08kfI4IwzWZKiqlPyJl/9pMMaaUXL
         vVoYwCq8/+GerFUe9dr38GlP213Usq0iOXdTx8TV/fVSAIOsYvyOTvRS6ylr2US1LR4n
         wO+VD9pC4DDhDKP8ZFDqNlKFhq2fuG8nSF9mHV4eci5DDT5kE9yibkb2ayyT0OcYAiG4
         gh1w==
X-Gm-Message-State: AOJu0YxfdWIoOU/SfxBq2mC82gqnO43+nUCTv7rkiSsf0xyfhNIr9k/F
	q+2KLwrHKl85biMs1WuJt+0fgt2DAzepA2jWIl/2OoYqdemPPGzju8hpjnaKk5w=
X-Google-Smtp-Source: AGHT+IF6XOItqH00sQYxfDOWc4u82K+e9hnRrOl6nNNcogyQwgpML+LxeCR/3nKZA7iv9rU4AtEBnQ==
X-Received: by 2002:a05:6512:490:b0:518:f4e9:201c with SMTP id 2adb3069b0e04-52407ac1076mr1134129e87.16.1716128891611;
        Sun, 19 May 2024 07:28:11 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:8916:b54b:e251:a0f3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52436b546d0sm202516e87.273.2024.05.19.07.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2024 07:28:10 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Follow-up: CXL benchmarking
Message-Id: <2521A59A-98B0-436F-86B1-1B64A214A84C@dubeyko.com>
Date: Sun, 19 May 2024 17:28:07 +0300
Cc: linux-cxl@vger.kernel.org
To: Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)

Hi Adam,

I believe if we are considering CXL benchmarking, then it makes sense to =
define
a list of target workloads or use-cases. I assume that it is possible to =
address
such use-cases:
(1) huge distributed relational database
(2) in-memory database
(3) social network (huge graph database)
(4) big pool of virtual machines
(5) ML training phase
(6)  MapReduce use-case
(7) HPC use-case

What do you think?
Do you have any vision of benchmarking environment and infrastructure?

Thanks,
Slava.=
