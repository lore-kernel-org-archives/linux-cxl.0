Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AC49B20C
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818345; cv=none; b=Gbx0TFfMT8QlrgvhbTaXIGLIWQDBezeETEfDRFcGZ5cP0SUtvrt8YjO/nxUNZH6jpI0vdIU5Mg0qA0UmnD7Y54zMyQGebpqxBRv37u4fAHn3nFDAgUwiMSxjaaLQ5c/RFAAJ7/Z7ej1XrQqfWnpY2+K6luvnz04TFPsJ8GkhlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818345; c=relaxed/simple;
	bh=zCThCBQHEg7zoILpu1wZQQI8Pc820V1e/n5FVw5TliA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VK/OlvZhBeixaouYw82cvExp3qmDGncHnsWWNSNJ1oi2FsVk8JtkFTTHjT+EZw6JrWNsrEmWX86jkG74ioOQ4JKs1XzmKrTWKOSrXYgBZj6YDg6lXfZHwtrCzVSpI2JGSFKAD/FuvQzArYHeFPhkJSJKOZtVWk56vnws26vBpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Z2jh8w; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Z2jh8w"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-881269371acso1959321b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818343; x=1792423143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Smdsi1BCXFX0leS6t8zLips+J1KQ1pukbcy1pEKTRmY=;
        b=a4Z2jh8w8IqAYly6Tjkzo55Wf3S/+kjfqshh5BFpINuDnQb6tsjnhZwIwDII8w1qZ7
         z1bcwgJcFi8Er8D5jji+1PKO0VCeD3GTgKulnkrgOsafJhcM89wY4l4l3EOVdikrh7/E
         MOHrqUFkpH2w72t2A3j6ucSNoKLIhlN8ip5Yrnu55J4fqPIVFeRaqPobXVqWvu1Wb5+R
         iXiQSXK0GYIf5mC+Ed9D+C7LO/4C7LUxWJzATDdB79XcbKUEM7BaxcU/J8UsPASb7bhF
         AmXlI9Hr5gi9ymVzAbWDjv3n1xvV8bAzMyJjnGTVh+mZJv3tvdHOst1jk5A5r3WA/0w0
         Ih+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818343; x=1792423143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Smdsi1BCXFX0leS6t8zLips+J1KQ1pukbcy1pEKTRmY=;
        b=R9JyvnO/gCrd0n/7idHwLWIjI6JR/sXGDfvP5NAIjvdcKnDn4x7z3TjOO0nkbWiHri
         oIfrtTbWbW7o6h/p0TGh9WThS3E113i40V+ZpeVjEsXE9xAWUMPwghY6mmB3KgXmUJmN
         5KtOTYB84Hf4O87kt/HY4RgOl8OMz3YF9FM0XUgDQWqx22UJcHOhXljnVK2TU1NUbS0g
         t9eqzOTK/thmCrPEkcFcLJdaTPDEHbZD1nweJi7yZGWRLWXUBUX1w89ro8NgqUPEloQ6
         88l/HeumABGs/4fzj88PPnh1YLnlrCyw6pAVJDY7tLUkbEQc26AW+6BSDb8X1MIXzjbI
         zIjw==
X-Forwarded-Encrypted: i=1; AKwUvBw2ZSiEKB7UKhIM8m6Um5q4An0xhM/Mu6EoHLER1EVnZ+/kb2lT0rbZ9O0CwCfZVRuwOOyTppAgZRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGv/PSegyhdn9j13YK6k0ZkmAmtEDAGjAtTCiyM3Cq9t3hyNuM
	81ja0SWxtqFJuPE3qLBw7++3LF75dfcUuDcAC2v6+P+19Hcsh8JD3vZ/
X-Gm-Gg: AYBFou3TWVfLwaehf1Fgn/+G/k92gSuQzD3k5/hDvwUXiQhgAOAjKHHFG0KH7lx8PXU
	4LDinGU8KMx+h1COPcjqkz9P6z91+liWo9WV6CW1DoZ5KDDlRQmS3mXpqhlDVi4oDQrJYQkBRoh
	m0lOMTkVCpe935aka9yl7ZJrI6AmbxJDsDFwQuISL7EZsx/3BF2EvcisQis7CAUwqdrvDYaC1UB
	Uzh2eYIfqoh6Gj50vQtkOCLO9dbzR5A+CBiJQftOsyRJV/BtxWUphoO6nTkZxzeJuuOrW/Ih3K0
	/Pz9gg1EyCmMbyenqFZnZv/XoxK/v5UdwSS+PUiRuSHVh8wBSaDdjoonvCuGGhcOvV4dK/KpD8l
	rmw3REdLrTZzkF15g2yq32j/IIU7rRWC40zSvcw1QgUuQQu03EAOUUI+24c0jolhWS7Zj4fixPr
	o0y1B0UoHNJY6iPS9gILojGdJyrq/uYNf8fa85MZ8rZH+SMD7w912bNLKd3r20Wdi/jISHoR+Xi
	+DfFi22snsjpfB8mACoSwgmKuesPD4/cmwH0E3rqpA5XHAutFAW25HGxfM=
X-Received: by 2002:a05:6a00:c08e:b0:898:776e:eed6 with SMTP id d2e1a72fcca58-898776ef151mr3214615b3a.34.1791818343199;
        Mon, 12 Oct 2026 08:19:03 -0700 (PDT)
Received: from localhost (ec2-13-231-150-91.ap-northeast-1.compute.amazonaws.com. [13.231.150.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896b68ef2easm4191976b3a.7.2026.10.12.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:19:02 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev (open list:DEVICE DIRECT ACCESS (DAX)),
	linux-cxl@vger.kernel.org (open list:DEVICE DIRECT ACCESS (DAX))
Subject: [PATCH v2] dax: fix dax_core_init error return code
Date: Mon, 12 Oct 2026 23:18:57 +0800
Message-Id: <20261012151857.22534-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

dax_core_init() mistakenly returns 0 on error paths. Change the
error return to use rc so the actual error code is propagated
to the caller.

Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---

Changes in v2:
- Drop unnecessary goto label, keep direct return for dax_fs_init() error
- Add Fixes tag and Cc stable

Link: https://lore.kernel.org/lkml/20261011132017.31131-1-jianyungao89@gmail.com/ # v1

 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45f84b0eb909..210f4af479f0 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -738,7 +738,7 @@ static int __init dax_core_init(void)
 	unregister_chrdev_region(dax_devt, MINORMASK+1);
 err_chrdev:
 	dax_fs_exit();
-	return 0;
+	return rc;
 }
 
 static void __exit dax_core_exit(void)
-- 
2.34.1

