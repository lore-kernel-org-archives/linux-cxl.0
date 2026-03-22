Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715530F548
	for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185404; cv=none; b=cq1yCYZ7UcwQK14PZ+yqfqr3EuNqdVz6kuWtaMqoFfI0b+W12Ybh80SFh4tnjrq1oVHF1SgFkqhqr+BUmXSM8mbKqEPBP3uXAssq/LOezDRvcVHD/AhCCDYfpW7UzPViqhAmnMJWRK4IuRIDxVoRRViA7yXi7oCnwN/Vsu8byxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185404; c=relaxed/simple;
	bh=QHvhCtbPfDexZnD6/atgOFNMEFsMKPbf5G0cPLGil9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrOxWIyl7z1TuE3oCXh2LsCrKVNhlz5ibRIKD8SndNc8qxbWM8bS2Jrig75vwyVgWWcoffI1YGsEo6sZy17QNmVUQTOdzD6MSb6YWPVbv4RRPPXYkCL5OH5bLz29QLCXyVFYKYAOYnt+y4i8wMJDuHiq0VvL8QPgjnfXz8XmCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eMhO94MX; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eMhO94MX"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50b351eaf81so19054051cf.3
        for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774185401; x=1774790201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ghy4G0c1Qf/8CuY4tcucJ6wAmQrYpDu3ksb+apRnd9s=;
        b=eMhO94MXFhClJyYs7lEsfoH9WBnEDkzXPzLKJskXtaZwi5sr2zSXfAzkVitk8OMzoG
         iq1p2yXX7X2EWbS8uxi63YmfBGnb1J/u/TngJ+6xi2m72aU5IJ5+/bSe2FgyHHX+3l/t
         LFDKJS6ruPE6t2YIV48P5qyNStAcT+X6M495uwuugGOH1F4qjUEZb7dlQ6Sj67PhQSMF
         tHRFalgEbzyayvGLkpWhCRL13Siym1KhVEcZMVKuHmjYEoKiVSqknZPQ8eY1hYXHwypE
         SPhm+I+DVEj6TUjC292SBBRTxOfdR4v2RvlzTMJUlbCC5DuStui+0kWc/yVHcP+D7SjD
         EK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774185401; x=1774790201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghy4G0c1Qf/8CuY4tcucJ6wAmQrYpDu3ksb+apRnd9s=;
        b=IhZLH24UfeQcZBClMb60VE5vY6ks0Rwtja+iOybf+XA0IoDE2RgbWKniw6J4h4iXJ8
         EoS0r1iImUgO0mEPoXs4Kmua9t9W8KEY6Z/skTYuKExoLLqQCF1PKjqEafCbjVqyh5yz
         XoWKinZWIW3/VQx1qafxO4+WbDomU1bP0nZ3YhAlQh9UWG+FSpWhQlOEvtqGk8Q/P1IP
         FrMc1D0DNl17iQJ2oXNQtNyrHmvTX3idpqbYtGsbRmW/RLhMJI8H4ztGW2GZxKW7Svtd
         bcMjSj3cYXxyP1xae1V5IH4IY87BSBmQ5gtaDypbH05HSw5oazSEfrMVYj6DV3AzacjS
         xFZw==
X-Gm-Message-State: AOJu0YyiXgsm55wQrCKJc4fOpkDBzge81zfjHiga78x783QCPj5SlC7b
	5dWJNR8wTYIC1Tw8Hs+Z+wMSCX9TOhF0C57grA+uho4LkY+nfTNMD66ixkNbChw25awkI3fOjlD
	KVZir
X-Gm-Gg: ATEYQzwU+vE2dk8l85JRajCLLNA056YQKlKIKsr2X8Mf8pGSeBCDULDkZ33HoJFhVf0
	va9lxXePgTEGzHPPIbcDSbMBf/eiQCuFI7qX7NgCo0w9Hsa2dTA98UQ7rzpfFd/Pxo/2erVF7ef
	EfVZQlVu60Kfzdo6cAOkIbF2+o7y1c0Q0OeIqfLsnkwdwe3jTy1/lbSt5ri6RnoC4Q5fmpdP4HR
	WsltQubft3GQEQWQZ2IuYWcUVzyH1f2QYBG+y7RRAeoFoFRlLMiqgK4ZTxCvvAikwwvvfegHfLS
	m+kMQxkg7s/QP0KDlJVXBNXhwsLtHfdqNeb3idQukj3NIgUG4bjCzzCRMubwxZjn7Fvv/E6LAOq
	xhs8UkMdZrDR0LM88ihcyFV0nSqxVVtMoRwxnmxr8gmTTKhCEEF7jhFtrpDjUowE9SuHMTXFGQE
	O9xG3AprcCeDnLL/q/QuC4cvHD79OvPjRVGo4VgmeYxRhm3Q0vQDbR2rhPxd3jA/IQV53saVJJ+
	ZVMyCapY94BZ1c=
X-Received: by 2002:a05:622a:248d:b0:50b:4f5a:b0fd with SMTP id d75a77b69052e-50b4f5abba4mr51294341cf.70.1774185401053;
        Sun, 22 Mar 2026 06:16:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e35086sm59688651cf.18.2026.03.22.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:16:40 -0700 (PDT)
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
Subject: [PATCH v4 0/3] pull region-specific logic into new files
Date: Sun, 22 Mar 2026 09:16:35 -0400
Message-ID: <20260322131638.3636725-1-gourry@gourry.net>
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

v3 -> v4:  address DJ's feedback on cleanup.h patch:
           move __free() declaration to assignment point
           restore local dev variable

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
 drivers/cxl/core/region_dax.c  | 106 ++++++++++++
 drivers/cxl/core/region_pmem.c | 189 ++++++++++++++++++++++
 drivers/cxl/cxl.h              |   1 +
 6 files changed, 300 insertions(+), 283 deletions(-)
 create mode 100644 drivers/cxl/core/region_dax.c
 create mode 100644 drivers/cxl/core/region_pmem.c

-- 
2.53.0

