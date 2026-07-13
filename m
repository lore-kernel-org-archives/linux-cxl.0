Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A2361640
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927443; cv=none; b=CVnAbZcJ+FbZi6f9AILCQ0WG3u87lsXooKw+HmDsXxfPMhm1VclB4ifKHuW/Do2Ikgilgz6cJ3rdui36A4FKojV1sb1ZRYgz+nV5RHPvnUNyeQf2rS2g8DBmjLl16BhgmcJGNpkCrVCwLL44CRPQDXGz65EzpHp/V9XXr3p5yjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927443; c=relaxed/simple;
	bh=12s6ad55gPgUsMzNZV1OVwQw0uP1yJbq67NW8tw6iP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJcQg688m5Lnpelpko0oa7t7MxIeMvuV+B0t3QWj+Gw2I7aGMpXy5W1NaBbZV87emGXYQdINrPjsJjarVwDQvRwWE5ovMaNLsmxX+GhCa7o812ofvfMZu1h0YR+limC4v/PzKkHXVVg7hkp6zp3XfidKdk6D+uvJKD3TzEqUMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rS/gsZvE; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS/gsZvE"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca92f36c4acso742701a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927441; x=1784532241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U377PjbcCXoZWc+3EuDN1mi9AZSmdy6wOFV7gOgTSkQ=;
        b=rS/gsZvEJzS7B1nL4wBZYSExXNrqe3mJ/upbzlGJCA8ueqP6VutOgZS0fvwgitXwY+
         359THTHdKh0Hi2KUNnuTcm76V7gsrHkRpeBwcrOSV2rrwpY9xw25f/hS6cfr4iFUpMqY
         dXYByJcamZFShIgMFw1zi9VWpmBSdSd8B2Z1zyFpsAVM7DaOg1X3WyZTYs8DDLKIwUqC
         pfLQyUPAB1N92CpdRijV7pFDiThki5An3PFd7UnwEK/eTNW0yXzzeQar0IZBwn5t9auW
         jQ95nLAJ0xnNuULH6dMTCzOsu/7t7eHu7hY0PJv43XHNTioSuVWTReiqbINWasMeYh+2
         Yk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927441; x=1784532241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U377PjbcCXoZWc+3EuDN1mi9AZSmdy6wOFV7gOgTSkQ=;
        b=o9T3Dr58cA0bGzneqk97HDvsoF8iL034nezrXVN8en7Mne9rFgnsWE8AmouSrbN/2z
         r/nDTOxxRCOtQGP+3mCZwyZOPgTApVEGlChadlorb7x4i6piUauNzRjNt7FMKvU0g/0y
         fHv1lEQ+NLXb//Jv0OdnmZFIomf0GEhYuhTMIcIDNOKrynU188sfzoeWXYWeRuuIewap
         7FwQB2tCegbjokBTbXLwlQbrKn5Uffuf8BY2iYa+zoszG6SdXwYN5PfwuXQg92rz7FLj
         4GAPjNgN7TEyUyNn2l1nQGMa5DjhCrMKI/vCroIw7eJT5CVS2CT0kxPVES171TqUBmKF
         anCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCNfAiGWQTGmI1we/GEl9VKqRtKC7cncKK/3BsNqZ2k8TEbBiw8cbeAP7XHnMRBaV57m9WfiqugoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9V8ACnaB622PL3Muyz/B0JO66FCxy+m34S/9dLsFfYhDY461k
	6YYfHZKBXlBamFYITbZG1ZNCwfacDQgIRKnYVITWlo0jxROmoR2K9Tz8
X-Gm-Gg: AfdE7cmC7qBAwNVNZVACwos7BmwkX8e3qRigB7D1E2FkxOZSPXTYmMsK3/o7aNM3lo3
	ngmwVHJ3PWDbuP9iFY8dGI5Dmx9hDvAv8CztEcNd2BoVS2QOu1ZI985dGQYeCUziBLxmVrP9gyB
	dyf8Pod00iIeyZzgXE1F08lx+JoC27wFDJgQtjLHPFHFBftVg84n4BOuqSQ0ovvcZlMDaaclSqc
	wcfynAZ3tVg7kbgFjVU4hUFZJ+Hm6ENGzCmCxkQtZpa0srK2yCjYn95Tc3RxFtYXUqEYuvFilIU
	cH9ZPm2XHYvXBW23dG4xP2prJ/rr662+Fflc/W3trXdiRp8l3h/mZM2WaM88ogtMbDnis3vvzzx
	WF8AafvtX+e7oOqD+Lb9hU33WDxNlKRIVOJmA51iCRbhfBB9TqbbeBVT/PR3nXnckTwTyI/6oj/
	3Arz/VJ7f2ndlGZv58ZFpIwWJDEbxjUnDgPr4AKQPKaIO4H5dOFYmKbc6B1d6cjG2IqXfSSPDUl
	iseWQj+dnQQ58Lm6vTHpsmufq3VwjL3nNCTUbQ=
X-Received: by 2002:a05:6a00:a117:b0:848:824d:aff4 with SMTP id d2e1a72fcca58-848896fee6fmr6810738b3a.56.1783927440952;
        Mon, 13 Jul 2026 00:24:00 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.22.11.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm12070765b3a.8.2026.07.13.00.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:24:00 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	mst@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org,
	Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH 1/1] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
Date: Mon, 13 Jul 2026 15:23:36 +0800
Message-Id: <20260713072336.623604-2-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713072336.623604-1-jianghaotian.sunday@gmail.com>
References: <20260713072336.623604-1-jianghaotian.sunday@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.34.1

