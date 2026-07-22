Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA245A283
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745339; cv=none; b=CJmhU51DKKf33grsT/SSRn1eE6MqIngCXS27FpFao+iEOCfRREBYag0F6vVodG9Cb8/L7rVyV+2ESxdhGzf0YVDs3eIIEQFNGuyac3WzfcnWflAqrLiPvEyGeNHGJRz7RVRmkeibx9Ui0aLUqLSHtR+2OMs6cyQlY+qE9/XU5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745339; c=relaxed/simple;
	bh=dgzN1ml/vZNStxUoITE7Akv2HnDMQo21x61Qfk5F2Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcACVCrQarvf5zstCOKTY8XB2YzFnJp7EfrtSKb5OpjeKDvRWZMP3kVpdsz3v94ekJwVChstYftrzWmjLf/3siff2p73VmIY26zW6+syc04ulIKlk5o8WMBKCi3KTAwMjx4fPPXICDNVzZ5EAcC9718kXMTYhzn6nXC67GjrDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fsfRs//5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fsfRs//5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0c68aa31so94808461cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745331; x=1785350131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ydg3Ew9SKlsgJPVrflLH252P+fWkz2RUOcmJ5pVt3GI=;
        b=fsfRs//5P24HlNTS26QUSltmlzIfNA+Nb3ASwPtE6pW3nZSX6yQ1XWK7eOaiwzylcE
         sP7tvGaxZ9CuMmHk2TEC4uX6BCcJgRmcH6hKzBtN8i10242QlMiQjVv33oTmRk8BDwTH
         5cBV/ihUD+2PY8DiWOhV4GR55HFhu+gf6wd66QXpx57Mrcj2om8zfd2nTSGVEj75Hx5x
         Gu/7i4l5A01RWn4xNo4iRMfrA6HxLORFVJdC0XZSsQcGGB5gjeGP//6Pjp8ISt6ais1z
         RYHT8dTws8MKY2KJQxPMvaXwsX0tD2S1DhC7MjFJfqtADWXhja/Rv+SZ1J06+JtP4cF9
         Cc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745331; x=1785350131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ydg3Ew9SKlsgJPVrflLH252P+fWkz2RUOcmJ5pVt3GI=;
        b=L/hSPKYPKDb/CTPzfoTuac2+WZ/pPbyfaqPAUg75UlpU2CAo330gzxLMxyJ3N0nOoo
         8h5KxJ7dinE1gWZukZQrEtsLeTImHGN/1UdD5s0U+e7qqoE5u3IYj4z1meHE2+OUo2Ni
         ZlwMPAJfk84ntLheEzupPfdDxSQ2Q3iNesp+ur62JNQ8YE1LSIuzdgr/kYbmqt49QH7C
         1Tkvij+KDMcJCoXpxG9yL9YNopXG6AxCpItUMKwWfRSyJQASb5rTzcfCot3fV5MuOBMW
         +fQSCKk3l+Rsluu9vduF06AH9+2LObMtHfdz08khZ2XhucqWEZ+9CO/qL7C8OPiasd1g
         8CAA==
X-Gm-Message-State: AOJu0Yy5QEITYblshwCSx1U7OCM/ko8VvWhb/lNVS2dX0dXoSCxwU13E
	gRrGPTRVY8L4d5jpADK6O64JovDmIqSb1uuh3XmYciFqrqq0PpX51V6hShtoD9+gC42fQQTwVQ9
	CH0Jm
X-Gm-Gg: AR+sD133+51+i0br01BiWCvFrumDNmQ7a9+eI17eY7nHch/eHkmF+G8qUXmqT8SQOaY
	wH7FQzreiuF5aF5h70RXg2tc+A7IYqq1QuiyRdrs90+x1QYUSpY8JsHmnzOWM94hz3dzQmQbqi7
	SZmCdCcMKCdvr8Rdi8p2vc8BFcbPEi5zc4Bv9Mnt7mEdrNLbHcqeM0e8fR8gd59rjYGEtUE5IWd
	MQcXZ+b52cwWv9Fig7x8aCmqLtlzrK5yCJBus7sp1JDWRwsGLQx5E6GuFw0+hycjYkOU7Fg3K/A
	0n9rHbp6DkhK86+ELsUQtASXvBYJ/pDCRK0BLKhJHoin8byBToGobFJ/reeMy+XxRktzIXlPKxN
	r0yFvrWZ4nPsH0ZAY/REcn6YWei3/JfEZPu3Vi7rWMWpF7rCe7P7SsPg9belLSsGGO6h36UQTNp
	a3bcgwMHrvPGmHDSOh9vg7CVpeRlaUhAraEMvYXyX+IZfK/yDBM3Wo6A5M/VGp+SBNKWi4aaKF5
	j6vKBoqef6P
X-Received: by 2002:a05:622a:ab09:20b0:527:6d4a:1970 with SMTP id d75a77b69052e-5276d4a1cdamr42283981cf.38.1784745331550;
        Wed, 22 Jul 2026 11:35:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:31 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 5/8] dax/kmem: add the hotunplug opt-in (CAP_HOTUNPLUG) for private nodes
Date: Wed, 22 Jul 2026 14:35:16 -0400
Message-ID: <20260722183519.935213-6-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722183519.935213-1-gourry@gourry.net>
References: <20260722183519.935213-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the "hotunplug" setting for NODE_PRIVATE_CAP_HOTUNPLUG, so the
node's memory may be bulk-evacuated for device removal.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 8023db23e2f99..3892ad44d4e46 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -630,11 +630,13 @@ static DEVICE_ATTR_RW(name)
 
 KMEM_PRIVATE_CAP_ATTR(reclaim, NODE_PRIVATE_CAP_RECLAIM);
 KMEM_PRIVATE_CAP_ATTR(user_numa, NODE_PRIVATE_CAP_USER_NUMA);
+KMEM_PRIVATE_CAP_ATTR(hotunplug, NODE_PRIVATE_CAP_HOTUNPLUG);
 
 /* Per-service opt-ins. Visibility toggled by 'private' control */
 static struct attribute *dax_kmem_private_attrs[] = {
 	&dev_attr_reclaim.attr,
 	&dev_attr_user_numa.attr,
+	&dev_attr_hotunplug.attr,
 	NULL,
 };
 static const struct attribute_group dax_kmem_private_group = {
-- 
2.53.0-Meta

