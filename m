Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247AE41A89
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155285; cv=none; b=WI3qkmsoKaRsODK6sdbJKluzmNMKz2evTp444AZBtuxkOYRfCO95A9jhSk2j8liPUqnsVyEiC2/8KrdMJKv/QjfOJ4s5TICNyGsRi2vIxsf04R2L/oFoiA1IL5+KGZtIlI834lPjghRE8yClApLk2dvPHrhjMoznEFMbqncpNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155285; c=relaxed/simple;
	bh=Iv2+2VbxUuO3Hvpk/53ikbEARB6VOlKEq6bifWKYEKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=La+HHUKSbJ1enuTW2V2bJS346cTt0sqg9wh+KQYGQ3TsUKMuRFZ7ElT9eZpkt/ZFf6JJIu5iSC0s6Ci4V1x4V4pdo4d9flhP+0Er+ITIqEITZnF/hht2DtQWuISGJ34nXy3h13OREDkEE+Ls5eLN/8WaGb3LNhc4rMOiiR2RILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3v69AMTtmnR4LAQ--.3084S2;
	Wed, 08 May 2024 16:01:04 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAHIjs5MTtmb2MAAA--.378S3;
	Wed, 08 May 2024 16:00:57 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: CXL numa error on arm64 qemu virt machine
Date: Wed,  8 May 2024 16:00:51 +0800
Message-Id: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHIjs5MTtmb2MAAA--.378S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQATAWY6gmcCxgABsv
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXw18KFW3Ar4rGF4kJFWrXwb_yoW5GF1DpF
	42v3Wjgrs5JFnruw1kta4rJFyYqw4SvanrWry3AF1ruw1Utr18Xr1IyFy3KFykAw43GwnF
	va1ktFn0qa48Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Hello, Jonathan

Recently I run some cxl tests on qemu virt(branch:cxl-2024-04-22-draft) but met some
problems.

Problems: 
1) the virt machine could not set the right numa topology from user input;

My Qemu numa set:
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \

However, the system shows:
root@ubuntu-jammy-arm64:~# numactl -H
	available: 1 nodes (0)
	node 0 cpus: 0 1 2 3
	node 0 size: 4166 MB
	node 0 free: 3920 MB
	node distances:
	node   0 
	0:  10 

Boot Kernel print:
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0xbfffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0xc0000000-0x13fffffff]
[    0.000000] ACPI: Unknown target node for memory at 0x10000000000, assuming node 0
[    0.000000] NUMA: Warning: invalid memblk node 16 [mem 0x0000000004000000-0x0000000007ffffff]
[    0.000000] NUMA: Faking a node at [mem 0x0000000004000000-0x000000013fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x13f7f89c0-0x13f7fafff]

2) it seems like the problem of allocating numa node in arm for cxl memory still exists;
Previous discussion: https://lore.kernel.org/linux-cxl/20231011150620.0000212a@Huawei.com/

root@debian-bullseye-arm64:~# cxl create-region -d decoder0.0 -t ram
[   68.653873] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
[   68.660568] Unknown target node for memory at 0x10000000000, assuming node 0

If not, maybe I could try to do something to help fix this problem.


My full qemu command line:
qemu-system-aarch64 \
-M virt,gic-version=3,cxl=on \
-m 4G \
-smp 4 \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-cpu cortex-a57 \
-bios QEMU_EFI.fd.bak \
-device virtio-blk-pci,drive=hd,bus=pcie.0 \
-drive if=none,id=hd,file=../disk/debos_arm64.ext \
-nographic \
-object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-device cxl-type3,bus=root_port13,volatile-memdev=mem2,id=cxl-mem1 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
-qmp tcp:127.0.0.1:4444,server,nowait \

Qemu version: the lastest commit of branch cxl-2024-04-22-draft in "https://gitlab.com/jic23/qemu" 
Kernel version: 6.6.0

Many thanks
Yuquan

