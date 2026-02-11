Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3331314B91
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842532; cv=none; b=KeuLYBzMWZ/ydCsuowq9OO4AHE1H1PFbUrtqn23ehGqjf7lt/6nfmvbdjR6LcPHUK/sSSs6Yknw2EznkPiitpEoKQKN/ylAG4miRoVLh+gl8/ujBZnpUDU2+BoDbGdrFYoJ0rQsEaDqqaGfMWZI2yeaKArxX2CBquq8UBdjvOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842532; c=relaxed/simple;
	bh=RyNVV2aTeJAPXQFk7HZ98hnR0E9wIlcxv3gnnmOk4+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wj2TLrnK02ccLEkGswiwuwbf44z7KX4mX+4C2GrnacafjHLD9YV1KhlmSK2ER9XJsVTYnLZUfY2A+U8fjjPioi+pTZoirCqHK00rIb1IdwUDzzWq/Ori4T5HkhEQUPZS33o2vi3to22Onxxb8nswGijDt3bA7Bf/6c/quXB55D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bjfQeDO9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bjfQeDO9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50334dd44d2so65253401cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 12:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770842530; x=1771447330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kbOMeKG3NhTF9/+UUVYIkyX10l4a4v4jc09OTOS4qo=;
        b=bjfQeDO9VJ3BV8tvMBebGddnlUer0WGjP4XzTD7Noh2c99Vfe7MXBSUmT7cJq7mtPj
         cpClNoHaZ7vkS+RCsuZHfmVZxAjK/faHOutqkz0i+a5QX00McwFuR/BnYXstqXg2/Rke
         Kicp2ybj7jOrfkal0Hms1RHWNwq7/c1GbkzgR6OdWtvLajeDRmz9w4SVW5nv2c7hLOIj
         4wjZRRqD6F4jmRcXc7IX9SWf0/kYjHbTgXz8nuSlfYCgd1FMRGBdJcCMIqTCavORHNuX
         KZkkeBrRkZo5acUFJmP0wf4DmDvDGj+VrPvp5ItqbmVGfcFM53FkafVs5yoBpI9PyeAs
         Kf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770842530; x=1771447330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kbOMeKG3NhTF9/+UUVYIkyX10l4a4v4jc09OTOS4qo=;
        b=dIj+N40K7rYcKR1+lz76dHL4YeNzayh1r8DesBfUfDVslEqdxiw6QVdrJ1mnscgLnH
         NTskEzXvCatZG2mXn+vtHv52JRQtjwhHoHnJf4ZHACju2LOup92JPSX03XVV9geI5O2s
         /yOFQGUR3T69eX/c1D9LMPG5hVj33oO5g0/GNfhUk7vDVnBeQDzSlAENHgnQndPNCyfG
         SgTbjg1E0b/TN39FA2K+tSRfRaLJXIaaVoW/dCyuJJ3Ly0ZR+WdxV2tdQ+9Oq6peDyKd
         BoWa/GAkjJhu91TIwhQH7pU4xXIpe8MXjEVVDfDUYbsXltvCVUX+OXh/BhGXHR5eXSvM
         T71g==
X-Gm-Message-State: AOJu0YznyfI0M6wU760KkHpY79QKs5U/ldOOkrpHxm3fHHCYDLhBk/mo
	FGYv6EPjO4pV2/idOVG+rqzkVRQt4YqLlfbr/jUu6opxkF2vDktQhOl2HV7XZcKD2IffpB+nFGo
	j4wXo
X-Gm-Gg: AZuq6aIfkXpy70NAJNIiuq8Bk+0xb4QZqs/EHMi7K6wjFR4SZtgxV9wpWQ5fLSFConv
	JBGOBHg1WydS/Hq22AOblRXE7chzt1gv35mzM61q+jC0SOudaiCEBLD2zrytHGrmN3mb/kHjDup
	Fo3rr3txoagCzu0hppbuGvmnYEx7vgRcy7dBdn5X6T+Xun0k1IdUefncmwjB+bDP5tAZQGe4N0l
	JKrG9MFd69iHeRUZGJXI+Kn+TDDrMRzw6oYTX3zcC928EkqudHlq+6w5Sj4ic82hAm2OGVJV0D1
	vJqh38XmslDje1jRt5ZK1ilU/1dN8xFZGIkwb/Gf+H61NziwoyNlDoqhtvBhJhA7fBcFTctVCga
	3chtkR56qlcdctl2MaJ3VCHzzf+i7My/nTVF+fQ42YCUQAwvzYuSmtpUu5C6yS6T8TVoKiS2BDE
	Mxm99YZ5bdf+Z6nZ9cHXCLRIjveDQqQJtZ0+4PaxzbXlq6vJk4X7qaXheU8QgeK/nmMJtQwEFfx
	o1RaR/rL2aofck=
X-Received: by 2002:a05:622a:5d1:b0:4ec:f969:cabc with SMTP id d75a77b69052e-506919e9dc1mr11162111cf.10.1770842530273;
        Wed, 11 Feb 2026 12:42:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d77cesm20173591cf.3.2026.02.11.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 12:42:09 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 0/3] pull region-specific logic into new files
Date: Wed, 11 Feb 2026 15:42:03 -0500
Message-ID: <20260211204206.2171525-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl/core/region.c presently contains logic to handle cxl_region,
cxl_pmem_region, and cxl_dax_region.  The cxl_pmem_region and
cxl_dax_region management code deserves new files to make it clear
that this logic applies to a specific types of regions.

This also breaks up development space so fewer conflicts can occur, and
it becomes clear where changes are actually happening.

I snuck in a cleanup.h fixup for devm_cxl_add_dax_region to tidy up some
of the existing functions.

v2 -> v3:  renamed from x_region to region_x because it's prettier
           added cleanup.h
           small nits asked for by Jonathan (commas)

Gregory Price (3):
  cxl/core/region: move pmem region driver logic into region_pmem.c
  cxl/core/region: move dax region device logic into region_dax.c
  cxl/core: use cleanup.h for devm_cxl_add_dax_region

 drivers/cxl/core/Makefile      |   2 +
 drivers/cxl/core/core.h        |   2 +
 drivers/cxl/core/region.c      | 283 ---------------------------------
 drivers/cxl/core/region_dax.c  | 104 ++++++++++++
 drivers/cxl/core/region_pmem.c | 189 ++++++++++++++++++++++
 drivers/cxl/cxl.h              |   1 +
 6 files changed, 298 insertions(+), 283 deletions(-)
 create mode 100644 drivers/cxl/core/region_dax.c
 create mode 100644 drivers/cxl/core/region_pmem.c

-- 
2.47.3

