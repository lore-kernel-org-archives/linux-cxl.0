Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09C2BE65B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576934; cv=none; b=SLdHP0cPfoQse/aiMUXm6QZYvvOPulikz2FHL9m8GnlqsPt7DdzbeOtQJlYEN5KUoTrxUNw3KtAD5iDelHEls48F1Yxc/R0KWJP7RmnZ1H3ojIbz7K5PyXBkulU0uCe8hcskw9QlyDc/8f0FQH+hZkk9AAtioDf2KxEZYlWUrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576934; c=relaxed/simple;
	bh=8d/FzeYmhcdnNj9iBzCwZxv7dHQdc58Ax9wYzddvuuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGW3dfxkxwj88iZmTMI1xkcarTXtUowiEzNiPIbvUM+LXSIAnkCLh4kmmnIT+spflPmjPq5R085n84cdBxGGr8a3OqA6qHQ4MQz3RNL+xlPiZT4Ru9s6RqEAgSeloaSMoCWkxi0gHWQTSuElt+O1arbWamGFEcetdL9BIHCMYBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nGrqleEX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nGrqleEX"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a747448dso14039631cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774576932; x=1775181732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1lzzPQFMdVBuh9B+X3gTJ6k80ziYznJf0fHkci4lRY=;
        b=nGrqleEXBznyJsPDwqgVe3FPH4NpGUNAH4WE14+61BJqvipdsOdMGjZB46/gm9bp+/
         Jkjxns1F3zy/24mrWCJsf+iAc8QmCiTvEUDlIIXVivYbfFkKmiF58s4qC2okih+AvvqN
         eJ8+s5ZnBq7W2MuX9GqU9AlZXbgiJfZNNEIGO9a1c0QDox3DKLERDnPzclecrj8FlhK3
         jxrMVaqSjLCNHYg/oBIExga4Sh9qUAB0HPSWZqYBjbhnRzYCTPUFnsWUIGnib/3F/fzH
         vcOZVhff2WIyZ5OGN/Iev+Zj72VxkF0OIc7VOKjsFVr8xHj7xYKtVwL/rAR52rOo9TQ3
         RiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774576932; x=1775181732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1lzzPQFMdVBuh9B+X3gTJ6k80ziYznJf0fHkci4lRY=;
        b=pZr+hOg6o5CLbW9H7/VoDVkXP/2cm/VE9N0+JYBevuYJArPSqbJOaNSmrK5b7cUlop
         xxdvhpAQIqL3HKMhPMWdRfnuZRr0IxvAHjkEMCH6E+qbGXDrcGSY5P91V8A76MsHRRJf
         xmB2PkVuOixTNtDhqyB3/It2tdaf98ZjsGqVR+B0K5eJRVcVF05VpyrtcI1xPoMuOkyY
         Smj15BXmsXu9//NX4IDqc3mB259kVAC23s738wTgXMgtXFRT9hltmtzFMgYeC2LOG03Y
         UeZwAqpfoiPRvKmnvyrc+Va79LFBS+hFJKFLm+SPnefvsDEiN3GXKgDOvpJ2A0BenwwK
         Ii4g==
X-Gm-Message-State: AOJu0YyTc7CI+ZTNW7Un42iyBuyWIJX7zYEjsqYpUHPxBCvZk/C07NSy
	jPXuNfdyKqSVENzgfVBLa6yCLZKVj+5TG3h+DYsflw3ik1nwnYuQw2fr7Y4g9CxVrHJn94EFYP3
	9dDPH
X-Gm-Gg: ATEYQzySRggqfGmgtrQ9EVH3axhLgRUCl5kfMQGH+vB5DNGgW8QcYNpBWdeP11M51cp
	kvxS/2zzTAPtSjAydBv1FhJvNd5MYXJDK9yiVeXqRPzpEfZg5jH9rHr3UklQig9Su7YoVKxGdwU
	O57VI+7thNdIKWpCjOU/tPYM5XPv+cYZs/wY9LP1mcgJTpmpVK+RIxRM0geJPGxNsZJnD6QkJYo
	n8BnRSMcPBhXhAn31XyevfHZSl27PJJQbhVjUJj4ZCEcR3I8XbfUjrh0vJv3BS/IF4BmLqM1ITQ
	My0FcWS47acG6SHHyjxnentGBHg1LLyBEQ+wvEhSfc0BZqPQY26f3xplU6IRiSNTWYQhJhP0ogZ
	D4RTX4DG+AQ2HbeRgGXl2uIkUo41dsE8JbxXqCOkff4ykvF8nKeKQ69wUuoO+DEsE5Jhzfaif6N
	9NNuRkrJ0QNJkMUvOq+LmlE6/3/wWHLU5mot0=
X-Received: by 2002:a05:622a:1492:b0:50b:538e:93b1 with SMTP id d75a77b69052e-50ba37d359cmr11753201cf.5.1774576932195;
        Thu, 26 Mar 2026 19:02:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b923c0fc1sm39158901cf.27.2026.03.26.19.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:02:11 -0700 (PDT)
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
Subject: [PATCH v5 0/3] pull region-specific logic into new files
Date: Thu, 26 Mar 2026 22:02:00 -0400
Message-ID: <20260327020203.876122-1-gourry@gourry.net>
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

v4 -> v5:  Ira test fixes
           Jonathan nit fixes

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

 drivers/cxl/core/Makefile      |   2 +-
 drivers/cxl/core/core.h        |   2 +
 drivers/cxl/core/region.c      | 283 ---------------------------------
 drivers/cxl/core/region_dax.c  | 106 ++++++++++++
 drivers/cxl/core/region_pmem.c | 191 ++++++++++++++++++++++
 drivers/cxl/cxl.h              |   1 +
 tools/testing/cxl/Kbuild       |   2 +-
 7 files changed, 302 insertions(+), 285 deletions(-)
 create mode 100644 drivers/cxl/core/region_dax.c
 create mode 100644 drivers/cxl/core/region_pmem.c

-- 
2.53.0

