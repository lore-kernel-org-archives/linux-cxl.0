Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847D38C2C6
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287401; cv=none; b=RfQq0Lr2XNMMDvQBZjF3G1i+AndrHHXsIiEMOwqcSeqOwgkWi+xV15XaTXY/fopRcq0z9DQvDAoeoS8gX2vt4KaYid8F11ygaP7n0Uksd/QA2Wv9DEj2MStFx8DoCUAjBzZ+wHaPY9oGR0DQTtHlurL9iXl6+71niIl34dkiPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287401; c=relaxed/simple;
	bh=48CBAiVLI24/iZduWhrvqOuRvaOxBYrMQGx5TphZKVI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+NjpadXiR8InBF1RNVAtnYvjLNZrhrmWiqEGAFlwl8qcF0eGYbpsMloJ325BEFXoKhaX79QNFExKfd9md9vr3qmhJnD+9SVBYsBbsPPp8BSeYQ7U4KkjAkeW5RH81E6OunMMDsVFFHAdSoqEzYmQpKdr6lPkdcpIEgkq/27ghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEAqpHK6; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEAqpHK6"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c09f29b64so583783eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782287400; x=1782892200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lnkemTVFtevu9LEJarGGlEd0BNgo1KPMK+RxKbsyiwU=;
        b=nEAqpHK6NC1ydmPefqLhMHUh7AwrQzivNZM5d2bUJAZSSvAOgA05oD4IPnjvbzW2Xa
         2COunjmMHkX1fJR0UHdnJDAT9a47PtjxZ//UfKEsdpbXNqyYAspL6V/6Zxxb9bycsxu+
         1B3YPDyj5rkWnfg0hgF5suMrt8MOwSJpya0tiQ3cAJZP1TD+ZrOkuN7m0lWGf1xJ5lBn
         0VJiBYBlNC80Cpgnm1Qsv5M7Ya2qd4KC+TveH4CqtwDbjLl+TlefbZY5txvzWDRlkC+O
         FW6KF6pngrZ9aj8X8Njuhyl9vz9qs6o1fo1YQ3GX+QWUQH41Fvq82ikCkaAhUR4+tlmS
         o8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782287400; x=1782892200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnkemTVFtevu9LEJarGGlEd0BNgo1KPMK+RxKbsyiwU=;
        b=T723xoJ0gdjXa+LjJVIznEVYqWtu66gGUfbi7OBtlN9MlZMiL5ZDPtsQSn+0ZfAqxx
         b3j5UMj9CaPjd7rdblWi6073mBoy8Unu5GnDVNGCIJP6kvDdsFtofjfeiKb6aY5RlELd
         tZg0Cfe3ngsHEXAomZ4r/SlFzU5lEh8iDgSWdTqmTuiChmTHR6ZhBm4VNnsvOwiOQUhU
         GsHGX94sBWGE6Lj/IDAjdYCxn/5mmyPzYgDL5Wb0IUreM7cP8+zUYtJ/RDBc2h5oka2R
         tzcjbEBt26Xhzg8eGv4goJ7WhS291j/yVSwfH+9iHET3sZubT67LyBl9KAtbDT1AWf9u
         BA/A==
X-Gm-Message-State: AOJu0YzP4BhZXN+KXG/2ZlEtppAvke9jHNmrMGXFg+HJPm9AoGlLmfCO
	qRjdulTq1Dtf9owJ7kI/KGmocsiQdOMKlzBOn71qec1ZIE+MWBM49gP2
X-Gm-Gg: AfdE7ck3PmLesGSKHL339oGPhS2uR3fguq0Hqpodcgs/+5pUAM7qDDn3/OwRgYyRJ2c
	WlSiTixkN01KhH3LJJibJh+5caIhP3MwrB1rl1r21h16Nv7xo2McBAECayfWKMIVaEwEMZUeEaN
	n/9/ZWgsc4lnN37eZRnr4hIZ0ecwEarPumbjWqrg1TzWbOEp/1+ruqg/LbQstzsEm1+HoCTq2D7
	X8Gz5xITFbjbq4TxQX6+9ESoiPsnm0Fb+N4+E9gDFa7iPG2X5eXpfznfsZkn58ewydoCPU6YJKM
	zviV18nMXTqEfgJwnb6uCMSjR+d9sSe7h3TcHWaF9K1JMKtIBt4tQKdKOCQWHh1J2CSm07CCcVx
	vN2+/L7/P6q1zAaDkWbl+W8tq8ONb+X3/A+8i4U4trI8m7Y2tDOPN3UpRch5nl1H0lho4pyJPZV
	4+uHeD23ZP/L72gyMBxN9K6GoRuZVzPi78WLbAH7alvVPr6zCu48FEAKYglRpZRERz46brN2Ek2
	k5sNWc=
X-Received: by 2002:a05:7300:1801:b0:2ed:a58c:942 with SMTP id 5a478bee46e88-30c5556303cmr6682109eec.8.1782287399572;
        Wed, 24 Jun 2026 00:49:59 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba57dc4sm21112608eec.9.2026.06.24.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:49:59 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 24 Jun 2026 00:49:58 -0700
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v10 00/31] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <ajuMJi5nTQRB_ZP0@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>

On Sat, May 23, 2026 at 02:42:54AM -0700, Anisa Su wrote:
 
[snip] 
> This series:
> https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-v10-23-05-2026
> 
> The corresponding NDCTL branch:
> https://github.com/anisa-su993/anisa-ndctl/tree/dcd-2026-05-21
> 
Making a note here that we were also able to validate a very basic
case on real HW of adding a single extent on GNR-AP platform with the
given kernel branch + NDCTL branch, create a DAX device from it, as well
as run the FAMFS smoke tests on it.

Since I've made a ton of changes based on feedback and plan to send out
v11 by EOW, I will ask the team helping us with this task to try more
cases on the next version and report findings as they become
available :)

Anisa

[snip]
 -- 
> 2.43.0
> 
