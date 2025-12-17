Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F12ED87C
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006032; cv=none; b=OtGdvmLfPxxTTg3SwY2mdz3Jlg1sMI9wIIOSj27xlAZ9rkNP/lv32zT2WXWE4mHIyYZwDzQwNmEjEmsNiZCumK+KciSV1J7p5d6/Bru7rMMQ8EqhXLOAM0kMBkAi6NUWbAi1glvxmzaVuc1phuX7bzvgv8seqYmArdQZyOwk230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006032; c=relaxed/simple;
	bh=H6Dnvdf9bmtdIjrm3kzMHDEtw/qB7Ge+CUXBEkKfJQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK80GIQKyWmL2zTe8zIY7VChHOvF9MuFPVHAewNT8yjYZGRN1JhoEqkGBbPJFKc2EzJx/87sRtjTR07GUjagPI4WyhesDcvLYYjmonJEYd0OPrDwX+r9uaNiR8RDufwfNru8kalwY7u8TyzFEYqF+19dy6VeEz+0GOPXOGXj89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjUsuM3B; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjUsuM3B"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7caf5314847so2821747a34.0
        for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766006028; x=1766610828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WykdBCYT8yJh4sQTY3N188JsaYBSsyfv2BDjqpmbRM8=;
        b=ZjUsuM3BbnWCEV1r0mJOiH8IiuyV8itGy80DbJ2DvaVz9XpYqHnyM1Os5jhx7SQPT+
         74uV/PE0mILYb2H+7izwWvGAgpqHhF9HSmwtjpICIKA0FxlJs1GOzSxTCMw4q6hVbKnu
         0h1gz5kc+Tx+PsFmhISimdbhRddvPupnkfzdRIqHxbK65nPPIFzg5ZjzpgpxaZn7Zi1+
         Ddrx1iWrBRJIzTbi158EGCv335o8UjbbwAY3Jk0ffx4IS3nxXvYLxRsOQ01LPOJNOm9u
         5nTxpcR4SdXc1LsIk822yGZBlMn8wt2UVvNRhOUGd63S/3f2jAmvQbzdIUHVsZLVGimp
         iexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766006028; x=1766610828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WykdBCYT8yJh4sQTY3N188JsaYBSsyfv2BDjqpmbRM8=;
        b=cpoV5pLy/T1WJmAeADfY/tngBy8YWVOHtdUoQcdPas3ioIW+oKj/G1yXZbe2l4NY7F
         YD6spBq6LBmoYjPheTVQpCI4rw0nl4kUKreeCFt33IYCZlVNdkFeKuonFHuukV4a/aHd
         A/3RkRz1yfvToRHjVD6eUo2r8P6WOWOzSFNCgWJxl5TSjwaxPh8aJlV0O0HtEof+3hBN
         6J6NOuYfEwk7qa5OlKmfma4NESi/ooFfJ92l5QmoXqBJSs8bR+chRNsA27F6cZx6CfF3
         ABN7sxUuR7Cjx2JjFafVpPRrYDF0n93xIyxqdj7BH5MzKJn0pTm0w7imRgetVPaEKG1F
         xWow==
X-Forwarded-Encrypted: i=1; AJvYcCU61M1DmyCn+QR8gyJGKuoRdj+juYMfhgI3khRwRjk7L8v0G+mwVqiwIZdsUvbTK/sSIekoheA6oCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNKsGHfAc01YLerF6/v7b82FV6gNia7GmwpHIEUq9SR2lYqqN
	V327Otswp3k/EscQ4pv5gKr2O//BhtbJG35Y8FctZVK1b9XMeXN9LbcV
X-Gm-Gg: AY/fxX53C89n/HvFfwbYShsqdtlGgq99lIzBpkiSeHpr0BvUz2ASR97LHOJxFQhHnjz
	jRyiUzDhjq/b3QqnlodXxQLOXeXFvFPxQkzLvT6OWcaUZ1ie/9kkdCefAQ8exoHId59QLT5Ymd4
	Vq0HVSEPweqpZyoJGI/4eZ21300H8KvTGIZxd400EbngDWzInwLi6qzbyJsIU9wSUuK01izX+I5
	Hl086xuuG/8NlqFw+O+c/HdqOfJJcVIPY9s8/Il77SzC55SSf+O1B6v4HcfTAsDDkZZ1BeXB66j
	z8VJ5ku4e8kMG8bGmwAmg2tYkHaUWh+YWZ68bRZvKY4vVpVW2hZMUIrcqhR9GO9gRRIcFD2t5Sy
	aMMSo/jKEEFncho6kmrkUPMN42gXpzTSNP4tphKAiHp04eL1B3uqxFmitpvCJ5ZVT4I3NClDxjI
	25fR7PPGNaHJEHUj+NNn4IEJSIUh3JUqPAg3aHgP28j8s=
X-Google-Smtp-Source: AGHT+IEJ79LfZmTkRRoNE6whe1Hjdhe/lgdvw3Z/AFdcRJKL1VDs0J2lLY280PufpqnuhZpriR704A==
X-Received: by 2002:a05:6830:254a:b0:7c6:9d7b:b033 with SMTP id 46e09a7af769-7cae8355339mr10935440a34.22.1766006027800;
        Wed, 17 Dec 2025 13:13:47 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a468:73ca:1f36:d52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa179f3a71sm354640fac.0.2025.12.17.13.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Dec 2025 13:13:47 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Balbir Singh <bsingharora@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [PATCH] mm/memremap: fix spurious large folio warning for FS-DAX
Date: Wed, 17 Dec 2025 15:13:10 -0600
Message-ID: <20251217211310.98772-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

This patch addresses a warning that I discovered while working on famfs,
which is an fs-dax file system that virtually always does PMD faults
(next famfs patch series coming after the holidays).

However, XFS also does PMD faults in fs-dax mode, and it also triggers
the warning. It takes some effort to get XFS to do a PMD fault, but
instructions to reproduce it are below.

The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
when PMD (2MB) mappings are used.

FS-DAX legitimately creates large file-backed folios when handling PMD
faults. This is a core feature of FS-DAX that provides significant
performance benefits by mapping 2MB regions directly to persistent
memory. When these mappings are unmapped, the large folios are freed
through free_zone_device_folio(), which triggers the spurious warning.

The warning was introduced by commit that added support for large zone
device private folios. However, that commit did not account for FS-DAX
file-backed folios, which have always supported large (PMD-sized)
mappings.

The check distinguishes between anonymous folios (which clear
AnonExclusive flags for each sub-page) and file-backed folios. For
file-backed folios, it assumes large folios are unexpected - but this
assumption is incorrect for FS-DAX.

The fix is to exempt MEMORY_DEVICE_FS_DAX from the large folio warning,
allowing FS-DAX to continue using PMD mappings without triggering false
warnings.

Signed-off-by: John Groves <john@groves.net>
---
=== How to reproduce ===

A reproducer is available at:

    git clone https://github.com/jagalactic/dax-pmd-test.git
    cd xfs-dax-test
    make
    sudo make test

This will set up XFS on pmem with 2MB stripe alignment and run a test
that triggers the warning.

Alternatively, follow the manual steps below.

Prerequisites:
  - Linux kernel with FS-DAX support and CONFIG_DEBUG_VM=y
  - A pmem device (real or emulated)
  - An fsdax namespace configured via ndctl as /dev/pmem0

Manual steps:

1. Create an fsdax namespace (if not already present):
   # ndctl create-namespace -m fsdax -e namespace0.0

2. Create XFS with 2MB stripe alignment:
   # mkfs.xfs -f -d su=2m,sw=1 /dev/pmem0
   # mount -o dax /dev/pmem0 /mnt/pmem

3. Compile and run the reproducer:
   # gcc -Wall -O2 -o dax_pmd_test dax_pmd_test.c
   # ./dax_pmd_test /mnt/pmem/testfile

4. Check dmesg for the warning:
   WARNING: mm/memremap.c:431 at free_zone_device_folio+0x.../0x...

Note: The 2MB stripe alignment (-d su=2m,sw=1) is critical. XFS normally
allocates blocks at arbitrary offsets, causing PMD faults to fall back
to PTE faults. The stripe alignment forces 2MB-aligned allocations,
allowing PMD faults to succeed and exposing this bug.

=== Proposed fix ===

mm/memremap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 4c2e0d68eb27..af37c3b4e39b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -428,7 +428,12 @@ void free_zone_device_folio(struct folio *folio)
 		for (i = 0; i < nr; i++)
 			__ClearPageAnonExclusive(folio_page(folio, i));
 	} else {
-		VM_WARN_ON_ONCE(folio_test_large(folio));
+		/*
+		 * FS_DAX legitimately uses large file-mapped folios for
+		 * PMD mappings, so only warn for other device types.
+		 */
+		VM_WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
+				folio_test_large(folio));
 	}
 
 	/*

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.49.0

