Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA98139CE3
	for <linux-cxl@vger.kernel.org>; Wed, 14 Aug 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668799; cv=none; b=ElNGMQ5qYPjrdvwfO7w926ctb6vDgySMSHK7m8yU5TgB7a4Q3PCM0TkasB4pbu5Ora+gARhmNmjVh2FvppHTrsfF+dnBe/ZwT45QFvkfVWMaYq69RHhcAbICxXCVO51yDLllcHCBJUTRrO75owrQEjSoMjHM181f7bofsihx3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668799; c=relaxed/simple;
	bh=SJWzwyGlv+Nc8gQ9e5HFpvciRIYV9HLX1vztKo86ilg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GeqwaVHUB/LwnWYmGLZmMytRMBihGdS0FyL6uTJlCSR9mCoe84UREnulUKr5poufDR5GEyLUy94sChwL3ly8Vrd3fN26JxYsqhmE9c1+CSbo16MiBXh9Ch2F+M7m/9GWBWVyk9lnGkNUK2IJ4JWE5JFHzPTC9/7B4fe7lx3uOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fa2Le+S7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fa2Le+S7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-699c81a261eso7242367b3.2
        for <linux-cxl@vger.kernel.org>; Wed, 14 Aug 2024 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723668795; x=1724273595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ot60Zu88uKZNlfK9OMlOraVIkgp3HHdV4RVMLpS6rbU=;
        b=Fa2Le+S7rrAqDXXHSB2Xun9B93sebOuhjGeNH2GGlYoA9SpmnHmBS8+rl7GkaXa9VL
         7/FiRd6dL26NqNOLAbSOP6XvkpCSIiskAKDyd20wni0gISEbWwlV7bDlVzyKaq4Aj7LX
         Bt4HkxF/Et7lCTSR15MRpSC+3ymum5I6QAp+ZmdqIu+UnGE9EiaTnyUa4Hqo66FXdzYC
         a+X+QulKv+4ugc7SAQFH1cL3bMW0/AVuS4vVX4fWy6wvK9pDfTi+7YVy23ZTaezNLDUc
         +Cx0nuC4HKWGAJCIzFwa860zI5THlQO4c59MBqN1WZS09MUt2hEtQHz+NbY2jp6J6KHT
         sS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723668795; x=1724273595;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ot60Zu88uKZNlfK9OMlOraVIkgp3HHdV4RVMLpS6rbU=;
        b=Aa6UXausLWZy8JOmL0dSi0MDKXvBY4BaDj65RBiPDPns5tP8flDZpW8ZptLl36Wgcb
         IBfOBbIXajCWfuZPgV8ATEU2Xaxu6HjZ4g3aX+IkLi5UF3vK+j4ju8Orb4jhBjSqnnM0
         giYu0qifUoOrvZPyVvtB6uNdVcEQ1O2HA1gdoYUW9kb5ncFPCmO6115pmaH8gU0ShX0F
         lIt+hhNLf+LGDLwt7HUm0+pbZ1MNN+7vX7wwUbaAkAeKdUWbRgjrIRssh45YByIJ8IYx
         F8aanjvOkLLhvuW/PqyS7iTTKLURSjNJcz5+2kFJo7SFrxo9oHAUvTwM7AduFWM+mb/v
         En/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnPpb3WpddUt5Ay4qqhZg27Qxa2D/b07NX7nMsnn7y1UBu8TdUVaCuZGCKVkrbHOL1yjPQOgnrywHRAzm2kypiayM8DADbIU+Y
X-Gm-Message-State: AOJu0YxQ4jM1Rh0/g1HT/uUrisvYWoodGnU1KHUCs3uUW18RZ9DVV2Fw
	Vje+X0K7OembBBUpbMHK/ZXCgD1NcE8UrwHklhCnGZv+XeW+R0MJfKLNsLo4ldL8qkrCPu00V1+
	MuacXBtZvzYeqZAUc3R7af7zy9Z3yRw==
X-Google-Smtp-Source: AGHT+IF3FJYsJiZdSjFbLc4zj2uVgVm96Hcc4lwSXgcRcF+ygJlB0qbJStfqMb0ucTmmZUVCnN+uNRAAN6/Bd1XHq17W
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a25:e4c4:0:b0:e03:6556:9fb5 with
 SMTP id 3f1490d57ef6-e1155ba2c78mr59475276.11.1723668795372; Wed, 14 Aug 2024
 13:53:15 -0700 (PDT)
Date: Wed, 14 Aug 2024 20:53:03 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814205303.2619373-1-kevinloughlin@google.com>
Subject: [PATCH] device-dax: map dax memory as decrypted in CoCo guests
From: Kevin Loughlin <kevinloughlin@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kevinloughlin@google.com, changyuanl@google.com, pgonda@google.com, 
	sidtelang@google.com, tytso@mit.edu, pasha.tatashin@soleen.com, 
	thomas.lendacky@amd.com, pankaj.gupta@amd.com
Content-Type: text/plain; charset="UTF-8"

Confidential Computing (CoCo) guests encrypt private memory by default.
DAX memory regions allow a guest to bypass its own (private) page cache
and instead use host memory, which is not private to the guest.

Commit 867400af90f1 ("mm/memremap.c: map FS_DAX device memory as
decrypted") only ensures that FS_DAX memory is appropriately marked as
decrypted. As such, also mark device-dax memory as decrypted.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 drivers/dax/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2051e4f73c8a..a284442d7ecc 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/cc_platform.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -303,6 +304,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	vma->vm_ops = &dax_vm_ops;
 	vm_flags_set(vma, VM_HUGEPAGE);
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 	return 0;
 }
 
-- 
2.46.0.76.ge559c4bf1a-goog

