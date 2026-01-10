Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892319CCF7
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072692; cv=none; b=Ev+olqz4N7TeEXqMGDpRli5f7jSL2beFJp4AtoF2xLw4L/Jfwaytrsjwt+hMj4WGNEAp85A5XHPFoJDE+7/6FnMOGmPFUxDqxp9KgqTMvaep1W3azKAdCPLEe4lNWNgigZy58tXODKG0PX71td6VkuYrU61dDDphHVst2VBAAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072692; c=relaxed/simple;
	bh=bGr4IMxuoPSV/rGQsuBeMGpMFNxbYa6U9ZhzkPYCYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVbGSDU3PgqGHLiJuS1HPT4+lIweH9tIFJJtLWjjbAC7q23ykvsKw/yt3nxs8PvUkK2k0KKmxSfd+aZNG1b5b69MeH2+5GYLyTJ9CuXYqD0LHZlSwH4osNOMKYwonIWW4OYuYIFIZeG08P5dfY3c47CwSfvDgjodnRslRNH1k7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6L4JON0; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6L4JON0"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so3683347fac.2
        for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768072690; x=1768677490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BEjUF7Vc4qXiTNlca0j1dqWD5DavB0AzDPTyw418Ev8=;
        b=c6L4JON0Psh+gy5JK9gCxjoJqN4Bcv6PGnsYKm5qBKcpVOlNd5ODVyVw3n+i6r1ICR
         IsZMJcs2oTSZ/lVdNHYbXy5NYN5nEWq16giAkcjaCUmRcGGBzqKyve9O+DqoZ7IZ4Kwd
         ysuKYqVEnG+Ke2F4i7f7OkcVwaZDLmAvMsuORNGnALo6c+xiumnHUfPuaagDTADJFnX8
         XCqkELbnjKXxc9NeAn49HxYBaFOkD1d06I41xyZudPSogPvsoEBRf0/bxwjLkRb633IR
         gxpHFED1kKR2PHEeoKYsSOGvJAo1akP2/zjrg02Bfdv+6BZdN5Fe5fUg4pnvK4XduGob
         yy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768072690; x=1768677490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEjUF7Vc4qXiTNlca0j1dqWD5DavB0AzDPTyw418Ev8=;
        b=NmN/F8NuB4U4gpnW7Haj0nCVfDqVgVpc1ndnGFARelq9d8qpGoyMkg7gImfjlrK66m
         TcXh1uTqFtAeNUiaoNHR5a8XZHEgU+0WUWQcRRY9pA/Tsnvo0fJv/HzHhy5WXD4hJffx
         MUgEM/DgL1cfNpJV6jGD2Y+BrwL3RFegATvtBZL0+/ArNjy20oAPV9egcd6vDgCPMn+P
         lu4rANncdn5HIkn9d62XBqTsr0uts89H/07Ne2acr/YRaSg3Ygi3P7Lz8F5Z81AARee0
         /qEomQtWEkXgI3m3W1EI9EqfGYmV8JQkJK4KLSBt/FMVRBFoc55EL0xS7i9GtBoQoWT5
         h2/w==
X-Forwarded-Encrypted: i=1; AJvYcCWjZit5ZR4jVpycLJCIs/dAnjwSyAmhOKcDr4fpdptJQauc3uI9KG8q8NUV1KsCni6j3o1lchSsnj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqPH8ck0fERQJSjOzNB6Ea6mS3sT1q/VW8AYzgKmcAhnwwwl7
	DxvbAHEffMA2Xgr469HRh1jJO6tOw51jRU5NJ701CHWhGwU9mYVE2jWU
X-Gm-Gg: AY/fxX4y4n4ghDjxQyAPpXK2XKXeV3hNSollhDvSARs1qKqa1loTHWq3djv3UrGPHV2
	iZXQ1YUDd4Qud5/k3JCJrQOoxx3qAYxJ8+u5Z0PnueLaRoNE9GtnnlpIT6lLiANqOKAP+CRlzuX
	itI3qlvlFM4qpTIlgYCPEF5o9udkmK3DM87hI+8c9+WtF2WhwtCulOsP0bcTcHSpw+JzpeJ4+PS
	9bRUWB25xu5qQjalbtjnfNbTY+PDALHj1kTN8zPLxifnhAQMIXaJgh8Qiu5Ry0rjJw4BVJDzjbA
	VLwvkUGCTnGtxtLM8P7vIQwqkng7B4AzeWtFX+KpmPQdlPiE52h/HeotJ2Kp8VYQYkMbpu6urpM
	WtW+7+J6wd/I3dwae0MnqQPb3f+t86BjiHoIAIJo+T+Rc4h2udTSODk+jX4hnqhJitJOXFPEtey
	M0XrBBOB8REbqxkx1B1V6bhVbJRLH8XzKldrfAW1g6h1oL
X-Google-Smtp-Source: AGHT+IEWrVmsDtSwCaHlxvcwwleGHry670J1sFrzbV2lGxKsnW+rkn8uvAhPl9HF13Q2e3f5Yn1hDg==
X-Received: by 2002:a05:6820:80e3:b0:65e:9097:3ee0 with SMTP id 006d021491bc7-65f54f74a47mr5503700eaf.44.1768072689894;
        Sat, 10 Jan 2026 11:18:09 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:7d36:1b0c:6e77:5735])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffb279e939sm8066273fac.16.2026.01.10.11.18.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 11:18:09 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: John Groves <jgroves@micron.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Hildenbrand <david@kernel.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V2] Add some missing kerneldoc comment fields for struct dev_dax
Date: Sat, 10 Jan 2026 13:18:04 -0600
Message-ID: <20260110191804.5739-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing @align and @memmap_on_memory fields to kerneldoc comment
header for struct dev_dax.

Also, some other fields were followed by '-' and others by ':'. Fix all
to be ':' for actual kerneldoc compliance.

Fixes: 33cf94d71766 ("device-dax: make align a per-device property")
Fixes: 4eca0ef49af9 ("dax/kmem: allow kmem to add memory with memmap_on_memory")
Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/dax-private.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..c6ae27c982f4 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -67,14 +67,16 @@ struct dev_dax_range {
 /**
  * struct dev_dax - instance data for a subdivision of a dax region, and
  * data while the device is activated in the driver.
- * @region - parent region
- * @dax_dev - core dax functionality
+ * @region: parent region
+ * @dax_dev: core dax functionality
+ * @align: alignment of this instance
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @dyn_id: is this a dynamic or statically created instance
  * @id: ida allocated id when the dax_region is not static
  * @ida: mapping id allocator
- * @dev - device core
- * @pgmap - pgmap for memmap setup / lifetime (driver owned)
+ * @dev: device core
+ * @pgmap: pgmap for memmap setup / lifetime (driver owned)
+ * @memmap_on_memory: allow kmem to put the memmap in the memory
  * @nr_range: size of @ranges
  * @ranges: range tuples of memory used
  */

base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.52.0

