Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176817E4
	for <linux-cxl@vger.kernel.org>; Sat, 27 Sep 2025 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932505; cv=none; b=RYZSpuFiwGLPxRn1G7UIR+eG3TqiLUecz/ATugcKsXWubmkwx7GZ90bIZjD5pXbQKKEUsOCDZ+MBChrexfJbfZVNKmIi1C3wD7sVlHFLZ3hbS/ejL5VAsp4xHrqNz7I+xeIxGtbiU7R/43B7o5plkCroySpf7z7Sb8rvdCn2sCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932505; c=relaxed/simple;
	bh=fGVl5iEOUqsyWw4eeEJe4XhswtCtS5zPwkYVkKqoBUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofMcLPQfeQdgTZDUnfPoaz5EfmmOaI4wInSM/WMzxK/xVtKkkx9iuXbpoMjKEwf9IaMjIWlfZbIUe+6fLS9dvqvge8SxTSCCzZxiXH3N/gGq/gW/Fd6uJt+UdAqlRZS6he0PistibKyr7tE4IPRvRBKKliWUXq+U/9HrnFhxLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpscJhp4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpscJhp4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f1f29a551so3691153b3a.3
        for <linux-cxl@vger.kernel.org>; Fri, 26 Sep 2025 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758932503; x=1759537303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQTR/LW73pcGQZucVeSjNBBl318LBz6n0O2J7WibIuY=;
        b=KpscJhp4vLQPTllWYNe2rSSwM/D4Bm1cLxAZf2fVqpwCtB3pCgPyWpGs8XuLIpTVcC
         zRLKdBE4+XuRRJ2mMTg8tpuMi6yXjU/H0W3am+4Clp5Y6kAMc5cPFHIK0FjFwX+B54jc
         XKud46WI6O4lgXRnQJDXMLdB1j2a31WuYOmHFOo9MpTgFiQObr0Mp3jvc9n66uVyxVZc
         +8iQ3rcjfaTHUwpVECeCdRF+lTHDHoY1WQH8tYsy1LlWOQi5w+vy5/A0Vsd83Vm5qt68
         JgOpElyt4rqM7OB49zAkptn22hTVkeJ2AGxJf3/gxsMmiFH9AUR0XVneD8ufWQxv6anj
         wFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758932503; x=1759537303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQTR/LW73pcGQZucVeSjNBBl318LBz6n0O2J7WibIuY=;
        b=JIrMMd6DNWHJcvErB6XQmVNTVZB8b0lV2u7bS5WlMV5BVCRg0g6ro/t/D8OSiN0h8R
         qIvmipTMgO+XtaqjmTM6R0CREWNv7hLPVVsKHjPOMIKyHB/Hj3Ja8Iz/XWjbxfoqNYv5
         vWnCo1PUC5irfRje8UCNuKXylW1x0U+g7uTChYxVeZS52282CwKzqL6UnKViqH4/1CKv
         0SIX268eMlPwn1shu7HvnVxcw2+a0mO/KArH/YKtEg90Tqxp0iOucoYPoe3cFw+M9X8d
         XksDEfUGZH7J6Mu+usT290TiKjyO/LxkWnMcCp/qWnvy5SwP6HrI4RDfuoZtr66tfFFB
         3+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhsf4dn1B52YMRFOho0B8XUcY59xv7yEbQ39L61XL7LDXD1y41Mt6CsB3XyD830hpoJU62DW5h76s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61x01+ZAxmTDKstj4S8KRnMnhrFfkSIhaJTXf7+jsxvbIKq2w
	F7sTZ/3qtdT2x9S42bhnoJfkExG5FiCxsdBWVtpmQGpbeR4scdvwfA+w
X-Gm-Gg: ASbGncu0Sf2wd5tN0iitimw9D6TRYR7vRL+YL95liAW1FcdWkdNsnSgQ2vVZans0gVe
	2gQ/woNXDR/gGyxodZZsfggUZP6wFTq6QdBVSyqVrTfW1VgMROHDXxpgKl78GMTgmfdw1hWy+62
	5NljeuI/rrl8zle6wAkmWLoRQ4tuh8/CeIw/gOmwfqHL100mVc4NcXuz6sHXgZMXKI8pgI6Om3y
	t7hB/0dSB3s0+KOReWmVYqqSFSWCRMqlB2jtINmhQEynvn3vCwwIl+oPJeS4bxd8pkWPr/PTzC6
	iGXE3kATxhOnOoQS+U5dY/QkIubHyzK3nKVy1F/xXH6+8/dl+93s8EFLMmAiP+8kswe2HWlKgYC
	maU9O1trj3RrMjPExzusL23Uf6pkFhqGjc9FnWQXjlBmiH6ps0J/dlQ==
X-Google-Smtp-Source: AGHT+IGxmhCV2WruVI+XO8VL9LJ3RKewJCIuMAwgl7jSu9H1qilIOZb32R7DmoucZ7lRJaQj+xypGg==
X-Received: by 2002:a05:6a00:acd:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-780fcec5cedmr10386545b3a.18.1758932502876;
        Fri, 26 Sep 2025 17:21:42 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca29sm5350489b3a.6.2025.09.26.17.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:21:42 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH 0/1] CXL: Enable FMAPI Add for MHSLDs
Date: Sat, 27 Sep 2025 00:18:06 +0000
Message-ID: <20250927002125.860668-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

This patch adds support for FMAPI Initiate Add command (5604h) for MHSLDs. It
is based on the following branch:
https://gitlab.com/jic23/qemu/-/tree/cxl-2025-07-03

This code was tested by starting 2 VMs, host_1, which initializes the MHSLD, and
host_2, with the following topologies, then sending the FMAPI command from both
hosts.

host_1 = "-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-mhsld,bus=cxl_rp_port0,num-dc-regions=2,volatile-dc-memdev=cxl-mem1,id=cxl-mhd0,sn=99,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=cxl-mhd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k"

host_2 = "-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-mhsld,bus=cxl_rp_port0,num-dc-regions=2,volatile-dc-memdev=cxl-mem1,id=cxl-mhd0,sn=99,mhd-head=1,mhd-state_file=mhd_metadata,mhd-init=false \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=cxl-mhd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k"

libcxlmi is cloned on both hosts and used to send the FMAPI add/release commands
from both host_1 and host_2 and the expected behavior is verified by printing
the response payload from the Get DC Region Lists command (5603h).
The following interactive program from libcxlmi is
used to do so: https://github.com/computexpresslink/libcxlmi/blob/main/examples/fmapi-mctp.c

Question:
Currently, the input payload to FMAPI Init Add contains an array of CXLDCExtentRaw
elements. The mshld_reserve_extents() function expects a pointer of type
CxlDynamicCapacityExtentList, so a loop is introduced to convert CXLDCExtentRaw[]
to CxlDynamicCapacityExtentList.

I am wondering why the typedefs for extents/extent list in qapi-types-cxl.h
are separate from the typedefs in cxl_device.h? Is there a nice way to avoid
introducing a loop here just to convert types here?

Anisa Su (1):
  hw/cxl/cxl-mailbox-utils: Enable FMAPI Initiate Add for MHSLD

 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.51.0

