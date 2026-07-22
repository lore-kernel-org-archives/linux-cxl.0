Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123374457AE
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745341; cv=none; b=jg2f8qp7NaEolOqA/pofs03wu1QtjK8TtrCm3jzlo5S26uJ970kx2lby0IF0ei+hzcxiG1howAmurehooXVnLvJQehuPajCG/VSYvFe2/wMGZZ4rb/Uz4X+akN182wtr6PoKZEI1RmuNwg1GhRwA1C67WZwI8T3oMSrA5ogww7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745341; c=relaxed/simple;
	bh=aZvh7cjs8n0vwVyW1NeCATzVIIYdYHctZyuk2o8ZeXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe0bfjpbTQGMeIihGYxPgusb9nv7l9CrZcGg5K3hYtXiPjB1jzWhBYvo8etH+JfWUmGTPfBry4Zy3hFDyvaZW+QVSxVuhxgrIJSMqTCJrw0X4ZLYrOkkU9hVV0ZnOM3fdngLetFk32s6tj2rWWVLwhonM3uHFCxPDFy82TljNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=okY+kvPi; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="okY+kvPi"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90004d2f7b7so172648126d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745333; x=1785350133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=omLFyYU+0hOal/m0+vDT5H6Y4PKzwMuevbEHJKxRO6c=;
        b=okY+kvPiu/63sRmR7mPZjbPzDqgM5HBKg/Vb6XvhwN+mVVNsjwx/iIYp5c8Qi1E6mT
         UsMLRhMaZNIddqJXGznSYzDlBCyot+iGb64BEa16hJKt8gp9zC1N+AwAjHt54QThkp6+
         lCWdqsYfx1k/wfMRh5LjeXwuAZ7raXP1XYFEH4VjGQMEP1dJFdTztoOSjPdrq6jZI2Lm
         ws71Hyt4C6VBPK5GSdHHgaEXGjAe/muR6u1/s/Fs/HuL8fJTJV00miDEQpdi4ZGuOE8d
         kCCFVXfuTUOkRe5O94a9OkGYTl7RM4QaOruwerViowLVSeV9jFVFu9Xbj+cBDNrI+8jk
         L6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745333; x=1785350133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=omLFyYU+0hOal/m0+vDT5H6Y4PKzwMuevbEHJKxRO6c=;
        b=dhJ3CDBOVFxJT9nm2FxsNJWIcPZzTuBm0+iehS0NlJq29KZTcsO2vvNOjs34OGEYwn
         UCzE9onCRILFbdXz5ByFH2kxPrF2pF/DGLxvoSkN8rvx/ptfo2By9yIhgPpzRGaCP4ge
         rT0RwpShN9SgihLl2q9oSDvRKbQDSaoVdRCIM0jLcKes3EOTfA5wuv+gL2IYiZACFW3x
         M7qOqoYBsU7nYEnR6zuxw20p4SSIMUbRGSckXwvK2N0eVZQRtfnpxEMr4GXaYIyZuRL8
         BXziz2dO4+JzG60aRFbpH29ZC8SScRB0X9QJDiUjTCeUSeE28xN4hdwH8frRZDUTLXSq
         OR8Q==
X-Gm-Message-State: AOJu0YyC831eyrQ+VKjK2JH3gMKncLP8UntDgERdg4Z/OpgdkfLsw+/K
	hNhyQGG4qjES2XY7SysQIW8XY3eTjl7cdR7Ov8dVwR69FsC8v8rxR4ziWv/LDVCrJQv7tLR5ApY
	XNvsJ
X-Gm-Gg: AR+sD10xJExpPZQ8xO8oWv79HAW/iMoUt/D/s+6GsYsuL1wT5e/JdU/Suy2m6L0RDHE
	M0VtXXCFnyDcdN1Dvx1xSTTbprbHfzl+UtKt95Wp9tyO3cxmrowAbJgEnnnI3stKEJVN9mcvuuW
	kfsAPkICmD4HEkzkN6hB/HxmgZQuw0U3XOTOeYX7U9cVVZ6JS+wUxhRHNfnkRjqBswZijvI7E7h
	IIuDD2tFtXVZxW5MMYmIjy6Rh7cjdJgKM1oDzfd4RNCN/FpxByJB1DjWWwRjX9Elszbd33jTN72
	akbeH323m+epAtxAP4D4bmzIDh1whxctklnLaCAusMz6327dm8Fut/jpnAg4fXsQqwMM9au0v+o
	M/a9QLFZ+BPw2eOpXgMbbpk2xAz6uW/trLsFIxzwHuC4zXfJXnsY1rv4HH56lrH3KIY7Juslu92
	qqioDs8pThpQxZpO8+XvKNu0vAz7xGRWMceek43jTEwqiZ7X/c9bl021l6QNbQJWmtepVyiLjZ/
	g==
X-Received: by 2002:a05:6214:3c9f:b0:8f0:2fca:8246 with SMTP id 6a1803df08f44-907ca56c5femr164246d6.52.1784745332786;
        Wed, 22 Jul 2026 11:35:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:32 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 6/8] dax/kmem: add the demotion and numa_balancing opt-ins for private nodes
Date: Wed, 22 Jul 2026 14:35:17 -0400
Message-ID: <20260722183519.935213-7-gourry@gourry.net>
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

Expose the two kernel-NUMA capabilities as separate per-device sysfs opt-ins:
'demotion' (NODE_PRIVATE_CAP_DEMOTION) and 'numa_balancing'
(NODE_PRIVATE_CAP_NUMA_BALANCING).  demotion additionally requires reclaim,
enforced at hotplug by node_private_register().

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 3892ad44d4e46..1cb3384c003e3 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -631,12 +631,16 @@ static DEVICE_ATTR_RW(name)
 KMEM_PRIVATE_CAP_ATTR(reclaim, NODE_PRIVATE_CAP_RECLAIM);
 KMEM_PRIVATE_CAP_ATTR(user_numa, NODE_PRIVATE_CAP_USER_NUMA);
 KMEM_PRIVATE_CAP_ATTR(hotunplug, NODE_PRIVATE_CAP_HOTUNPLUG);
+KMEM_PRIVATE_CAP_ATTR(demotion, NODE_PRIVATE_CAP_DEMOTION);
+KMEM_PRIVATE_CAP_ATTR(numa_balancing, NODE_PRIVATE_CAP_NUMA_BALANCING);
 
 /* Per-service opt-ins. Visibility toggled by 'private' control */
 static struct attribute *dax_kmem_private_attrs[] = {
 	&dev_attr_reclaim.attr,
 	&dev_attr_user_numa.attr,
 	&dev_attr_hotunplug.attr,
+	&dev_attr_demotion.attr,
+	&dev_attr_numa_balancing.attr,
 	NULL,
 };
 static const struct attribute_group dax_kmem_private_group = {
-- 
2.53.0-Meta

