Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA00329E49
	for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163982; cv=none; b=WPVKU6g1hxXpQi168dfcSSV7VOqj4Oit5IqoCOX8uSwvh3RmeFtgmqxowWj5cpCL1WRt/3WJE2usEwDe01XFJY3BNz3TxyQ3G53V9OXMLmbm10j0rY8jIPPqzy3SvINuJ5ISFf5jberjvI5lrIhHKgqaP4LBnvJrLga3xu5o98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163982; c=relaxed/simple;
	bh=zQQIdqNjp01QHJgc8T49LTRPfERcB9yikYEMSaVkSjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBewarOVJXiCYWGsDN9lNu6fOwv+Bh20ycKjWf9G1G1g5+08r1BO3Bt1MyTeBPcGamj8A2ta7VE33SwOjNM/aSfS2zS7fr+WyUnh78a22Fvsqa1dwknrZPmBJeeM7clOuIXb1eXb8eeDMWlGXR4rBBhYczizna7bEa5z9Mxn39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=C2JQleBV; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="C2JQleBV"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2d6df99c5so294342885a.1
        for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766163979; x=1766768779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAi40aONYYS2GMctKaFM3RiE3Hz7UFN2kCA4YupvU+0=;
        b=C2JQleBVJLosFAHXA8ac2qKskwiMAd2osixkMjIdzwhExEtk2qafW9sCaeAC8+adSB
         1Ehfi8FyGBghq01DkqBq0sNKBIzK5UUj52LRJ4wYIRhligd0XOOFSTlvwis0RGjd7m9M
         wBfGXLWrCMZO/ReqKo/5hpoS+c+L40BzBoGRkAWUd3p53fArs47S/1rHxb6racojYtnB
         BtkNC84urIH1XirOT+Nyn4NlizXen18XI9gv5InOE2k99IKbEXLPQZUAOdc+oNYkDHs1
         f0+PhnkcSP9AVPTrKel7ZcxNIIPjUsYLS0mMrVo6C30pTTRMHJZiu0WPoRhgK0Tbt9pr
         3QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163979; x=1766768779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAi40aONYYS2GMctKaFM3RiE3Hz7UFN2kCA4YupvU+0=;
        b=EBcrugRJP8ZAZhOJipRqjw7Um5w8olbtxZdd3K4GJb/+z5KpPraHKQ7H6lxbFSyG57
         pkmtGC1g5cRAdoZvMamgyWfWLGrb+lm/1IBaQrXaNyuup3fOaRj2jCBlKqjihUnNcWUG
         qXGlQSmepZ5ItuQhio1db6MD5Hfe1woWiRh43KNUP3CmKG8PoU3dQPqcrIapSsh7pzX+
         BUNcG6/MNCuG15jTE7bCG+aJMfhukjdQfAF2KWCNCC5uNl2PQ2L7IibWekn47+opUEgr
         fPy1B5/nVFt3dFSnfKKt9hF66yAj9wTaCPMmA8HpOqzhtj30dhKbJMtJcpV4WAqB4jI7
         oP0A==
X-Gm-Message-State: AOJu0YyoNKl+Ip7vhy0uYOcwXvpORrJ1FWqnfUJg62TP+zURnWMduHVk
	Det090b07jbVEuPi4Vy3k3XbOfXRl8OZE6SdnKw9SH7hR9cvbeOTGR6scN4p0tIlPHIkITXOOrG
	/tGQkV/E=
X-Gm-Gg: AY/fxX4+zDn1Kzl9MrLHYVA1I5AMOP9784Kas4xXBdYaRL59Vv1uvkw79FWjujjh0Ga
	mhHDYFQvkmAY/65K1xvba3eI3cKE4P2pDJUsjthJLD+3bcQB5Y3cbGqdKbymMphZGwsYWdIApmw
	QjSkOtHFraii4SMI7+ealhr/QUxFgIzwyrlJ/Al2n0rkxh+9Jm2sh1vxh9kaAVS5gNpLcnrktsj
	wEOkVO3BnEAAUi3xoaNJkIk80txtFDjmi2u7Wm/cQA9aoXrh2d1zSlmIpG4I/ixvF90P83Vrapd
	tJhB15b385tE+OA1uRCcueXtz3Nan9l9KMk2CCFwmOMBN5OWmZiUHLXAxg3bDoW5sefFi6hoWvs
	QjgfN4izJaAZbzM5n8qAL5klnWYdS8fTNAOA1wH+6NM349XJ1hj4J9wGpd6RAYiUkf5eba5gfYs
	0cZQYBGjJtceaBHe1RZ/39150Asx/MRpjOSaCI6WfGEiNNSSBNSDMAPVFdotz2mtuq8gDmmOtZd
	+c=
X-Google-Smtp-Source: AGHT+IGhbIcoK3R4lJkefP2BB6CcSiL4xwMlpDlJgBcatznJIZP2btkmkXBd4Jhxo+7BWvO0haAtZA==
X-Received: by 2002:a05:620a:2945:b0:8a3:6c1f:31cb with SMTP id af79cd13be357-8c090029a91mr524959885a.26.1766163979186;
        Fri, 19 Dec 2025 09:06:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096787536sm223197185a.4.2025.12.19.09.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:06:18 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	gourry@gourry.net,
	rakuram.e96@gmail.com,
	alucerop@amd.com
Subject: [PATCH v3 0/2] Documentation/driver-api/cxl: device hotplug
Date: Fri, 19 Dec 2025 12:05:36 -0500
Message-ID: <20251219170538.1675743-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some documentation on Linux expectations of platform software
configurations to support device hotplug.

Add some docs about general BIOS/EFI expectations regarding CXL devices
in general as a predicate.

Gregory Price (2):
  Documentation/driver-api/cxl: BIOS/EFI expectation update
  Documentation/driver-api/cxl: device hotplug section

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../driver-api/cxl/platform/bios-and-efi.rst  |  23 ++++
 .../cxl/platform/device-hotplug.rst           | 130 ++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst

-- 
2.52.0

