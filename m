Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A87F7CC
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724456; cv=none; b=VpOa62oiJmxAjCwSNdPME6I7cGMOu5zMrflF5ilGpoUqSwa/lqW+qL43M6ABCD+dD4fK4X2zVFNKZR6mQrwQ+z1qswpEe9oht4yfs9dc6tVO8BZQiVc64AFT8zjp5thAmdGFsY3SeZPi4azuXD+lQndU+kDYmNcbRpPKB2GYaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724456; c=relaxed/simple;
	bh=PssdZqeP4i4j3E93MGK0lvPzSFVTm4F7qPMQIcyRHdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M2D5w4tpbv9MWA+zJnRReGBBVmBseY0WFsda15Tq0JGKoWpH+gndTBEoOqZMTg87hROaiJGNIuiZfri9ddYAQuqMXLiQVw2e/z2/BeDY2TyOTEoxs/qjJyPaSzejfZI5JFXy0HEaLIaAIYnUm80KizTrtocO79CbRhh4cQjlHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBniXAYU+hlRBWQCw--.18955S2;
	Wed, 06 Mar 2024 19:27:20 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCXZYIQU+hlc28AAA--.730S3;
	Wed, 06 Mar 2024 19:27:13 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Questions about CXL RAS injection test in qemu
Date: Wed,  6 Mar 2024 19:27:07 +0800
Message-Id: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCXZYIQU+hlc28AAA--.730S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWXnc+MHVAABsQ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw4xXw4rCr4ktFW8XF17trb_yoW5Ww4Upa
	4xt3s2q34rJ3WxJa4DAFy8Z3W2qrn3XayDWF1UGrnYyFyjqr4rXr48Ka4Y9w1rKr97G343
	Xa4ktFs8Ga1DW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Hello, Jonathan

Recently I met some problems on CXL RAS tests. 

I tried to use "cxl-inject-uncorrectable-errors" and "cxl-inject-correctable-error"
qmp to inject CXL errors, however, there was no any kernel printing information in 
my qemu machine. And the qmp connection was unstable that made the machine 
always "terminating on signal 2".

In addition, I successfully used the hmp "pcie_aer_inject_error" in the same conditions.
The kernel showed relevant print information.

Question:
1) Is my CXL RAS test operations standard?
2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
   The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem?

Hope I can get some helps here, any help will be greatly appreciated.


My qemu command line:
qemu-system-x86_64 \
-M q35,nvdimm=on,cxl=on \
-m 4G \
-smp 4 \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-object memory-backend-ram,size=256M,id=cxl-mem0 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
-device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
-hda ../disk/ubuntu_x86_test_new.qcow2 \
-nographic \
-qmp tcp:127.0.0.1:4444,server,nowait \

Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu" 
Kernel version: 6.8.0-rc6

My steps in the Qemu qmp:
1) telnet 127.0.0.1 4444

result:
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 8}, "package": "v6.2.0-19482-gccfb4fe221"}, "capabilities": ["oob"]}}

2) { "execute": "qmp_capabilities" }

result:
{"return": {}}

3) If inject correctable error:
{ "execute": "cxl-inject-correctable-error",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "type": "physical"
    } }

result:
{"return": {}}

3) If inject uncorrectable error:
{ "execute": "cxl-inject-uncorrectable-errors",
  "arguments": {
    "path": "/machine/peripheral/cxl-mem0",
    "errors": [
        {
            "type": "cache-address-parity",
            "header": [ 3, 4]
        },
        {
            "type": "cache-data-parity",
            "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
        },
        {
            "type": "internal",
            "header": [ 1, 2, 4]
        }
        ]
  }}

result:
{"return": {}}
{"timestamp": {"seconds": 1709721640, "microseconds": 275345}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-signal"}}

Many thanks
Yuquan

