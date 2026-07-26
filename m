Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B76FC5
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101411; cv=none; b=t3KbOOdV7yaZeJ4lQZcN075l2LOvxTmFcOsIThLFmsiAWFrRc8vTXgZR78We+WwiYmOhvvdniQQwINwqVbGpjM4CORqaHjYApF8y5Bv5D5Oh1pL7UyOZynwp1d98QjX7F73yRDZ5Dvqxyko1pMJocozigViwFwEGosCLMUOS5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101411; c=relaxed/simple;
	bh=gsfwHDBL3Ajjd4WLPCETroICOfycJZVmoqYo5DQ4vvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AJ6/KVS4p8ChS9gQqu1aRWX9IA6EjcqclGxPYAvuvBcyGjiTbfYVS19gY9hjQgpQSCxxFsKg1GaSy8Q+ipwnA88yqu/3dNMUbgM+9pH3G4OO20rCZBnmWfMwjYloV3rn2TKSaAkUuRSoqxQtMv8e9sxZ8YEacVWi2BPzNrhrTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdW+5xKl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdW+5xKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785101409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmGEwUN6ZoBQwWGEsj9lWjkAqkITIK5CY/izBuC1F/k=;
	b=cdW+5xKlD9v7il1ri7cMTKp1rQ3S1rCJXpuGdWi/C5M6TcS/xgPA4SnbKh8OssYPiG/zVy
	VcZNfUhd/1jDGunsic0vjsMElDJ+yQgnQ0a9uzCQ6Ye/JKBthc9UGxmigF+Zdjco0Dg2le
	1f8edlJJKekSG/OnXbdctzs2DRv/CkI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-7WbUJas8P7SR89OpBijhEw-1; Sun, 26 Jul 2026 17:30:07 -0400
X-MC-Unique: 7WbUJas8P7SR89OpBijhEw-1
X-Mimecast-MFC-AGG-ID: 7WbUJas8P7SR89OpBijhEw_1785101406
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767b782so15142175e9.2
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 14:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785101406; x=1785706206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmGEwUN6ZoBQwWGEsj9lWjkAqkITIK5CY/izBuC1F/k=;
        b=TDmpXLT2XetmJwVedFp4FH0r+E3MiAsCAvzSR2CI588+98MPicVjgAvvSJ5qWx/uiF
         PLIv7acXzYQyJvPhhOFyMbqr0OMM4/3oqPmqO7ml7iQso8ZHhG/eFPUMGSLTK5SpGfSn
         hX29WLkxecNbngn2NgBulslfHfq81FlHqdIrLSXFnrOFlx+ZeoVytGVE+Su4l/gOz7OG
         Vqlcv2pWdd8XJeSb2Q62cq1lOYrgRaKY8NaFLFFJc471oxZGGaLBKobrg9yRA/8sWPwE
         xS1h0mqoPUisbnG5fOQSi6l4BFA6LdPO3d3QqVEl1Qq4vAjQWU3tVe/nCUObSSicHXRz
         enIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrehcsLq31ozjBFUOItifI1RXoEEbe3kUgwsHP+lC1F0cwCqGTd4evLQdfQpeX7FUyaIuBp3zakpuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSpRL8CvifWO27A6ICdLmpxZqH01egJzKqu2rOEQ9aOgI1ZO3
	bWbiZhULvo+2Xi6uWrvpiuyQf6caPIrViVv6vPuubGH/JtHU1X4Vhn2Rr2KQk5J8rq7zHTk4QQ8
	1eaJTuLU7t1WfvtTsO/mhsGOr6P5f5OZSOP+Jpn1LJCLD7G9wxMQo3KUFs8K0Rg==
X-Gm-Gg: AR+sD11eFOfhvM38Hu5tL8RGLm2mTfr8YNx/UbHSxCFfLxkpKnCt4uiFSNkSrbCGkZX
	ogITNiFtDzv6RZ2ra27Sl+BEUxRyHY4etB1CpVbxss2Svy5lktsFcbm1EOjzcbIkeXzgVVUMzgB
	k1ASLjTCnhXCXkrQWk7s9R+W5TSSi/LEWsTE4yzlyhzSeg1SuLa7UW20LPXTuxPaOpujpfAqh14
	/Zr3ax7fxOGgqpUtjVkF8KwCse9LnzvkAv+vIjI+9dHxiQrHv45M8G6OuRpgXTYSCeZ2XielDmQ
	i2/wH130W8Ttkh+8c9/VIyWnr5Ip+77GHhmyfBXuIKYTT8pRfmJneyvUr9rNTI6ETwSLklMw6PM
	RUFkRMTPfUWQP7xx5wCRA1Q==
X-Received: by 2002:a05:600c:4688:b0:496:bba5:33a7 with SMTP id 5b1f17b1804b1-496bba53519mr42463505e9.27.1785101406281;
        Sun, 26 Jul 2026 14:30:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:496:bba5:33a7 with SMTP id 5b1f17b1804b1-496bba53519mr42462825e9.27.1785101405693;
        Sun, 26 Jul 2026 14:30:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496ba82468bsm109682065e9.4.2026.07.26.14.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 14:30:04 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:30:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Haotian Jiang <jianghaotian.sunday@gmail.com>,
	qemu-stable@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org
Subject: [PULL 26/30] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via
 entry_handle
Message-ID: <19b566d397e382892af337e8b19e5676b9d36ac4.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5BnnrgZE1dfZ-hg4og86Exn9EC9MwjYiivFM-TwSKKc_1785101406
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

cxl_doe_cdat_rsp() takes ent = req->entry_handle (uint16_t, fully
guest-controlled, 0..0xFFFF) and directly indexes cdat->entry[ent]
without checking ent < cdat->entry_len. For a default cxl-type3 with
one volatile memory region, entry_len = 1 + CT3_CDAT_NUM_ENTRIES = 7,
so any entry_handle >= 7 reads past the CDATEntry array into host heap.

The OOB-read base/length are then used in
memcpy(read_mbox + offset, base, len) at cxl_type3.c:298-299, leaking
host heap memory to the guest via PCI_EXP_DOE_RD_DATA_MBOX, and
potentially overflowing the 1 MiB read_mbox heap buffer when the OOB
length field is large.

The same bug exists in the cxl-upstream implementation.

Existing checks do not bound ent: assert(cdat->entry_len) only ensures
the table is loaded; the minimum-length check only guards against a
truncated CDATReq; the entry_handle ternary at line 293 only decides
the next-handle echo, not the current access; pcie_doe_get_obj_len
reads header.length, not entry_handle.

Reproduce: build QEMU with CONFIG_CXL, boot
  -M q35,cxl=on -device pxb-cxl,bus_nr=52 ... -device cxl-type3,...
then send a CDATReq with entry_handle=0xFFFF via the DOE mailbox at
config offset 0x190. Under ASAN this reports SEGV in cxl_doe_cdat_rsp
at cxl_type3.c:281.

Fixes: f5ee7413d5 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
Fixes: 882877fc35 ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260713072336.623604-2-jianghaotian.sunday@gmail.com>
---
 hw/mem/cxl_type3.c           | 3 +++
 hw/pci-bridge/cxl_upstream.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cba05ec57d..28f41fa623 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -278,6 +278,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index b6281cbd4c..69773ff163 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -158,6 +158,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
-- 
MST

