Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC27FBDC
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731455; cv=none; b=DG6oFgGjr3YrfkirrayI5SeFtjG2vPPgs0zH2OfB6UeXq4GxSC38lDLZ53FxKh4RGtfivNjiO4GO+8LxfbvZuYi6pQGss3rPXJMDqw/7Eogbhn3YfSQ4AEyPtMBfjZpWG1E4iPhIqGujcnjaZEKPONGa7AGxBRdIlp42SqoetF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731455; c=relaxed/simple;
	bh=wo6JvuE7hB0RHQL6GSRRdtKu3KDbESgGThuarKcz06U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJHf497vZ5sr9peZZ00piajn8TWFzcPD2GjvmBiRPkMfjWq+8u+A5tZFKVXciQ8Ubt5u3lo+nVw1ZlKcDsRtLkMK7GWZeiv2BPG4xyzHM9Vf4vasfDvrqO9EcqB5lGUj9Gy8yiRXdE9F+kpgwbJdkr0sfVn/GT+MU1fw3zWLXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqY1G6v5Tz6K5pL;
	Wed,  6 Mar 2024 21:19:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AE8B140DB0;
	Wed,  6 Mar 2024 21:24:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 13:24:01 +0000
Date: Wed, 6 Mar 2024 13:23:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, Robert Richter
	<rrichter@amd.com>, Terry Bowman <Terry.Bowman@amd.com>,
	<dan.williams@intel.com>
Subject: Enabling internal errors for VH CXL devices: [was: Re: Questions
 about CXL RAS injection test in qemu]
Message-ID: <20240306132359.00001956@Huawei.com>
In-Reply-To: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
References: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 6 Mar 2024 19:27:07 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hello, Jonathan
> 
> Recently I met some problems on CXL RAS tests. 
> 
> I tried to use "cxl-inject-uncorrectable-errors" and "cxl-inject-correctable-error"
> qmp to inject CXL errors, however, there was no any kernel printing information in 
> my qemu machine. And the qmp connection was unstable that made the machine 
> always "terminating on signal 2".

The qmp connection being unstable is odd - might be related to the CXL code, but
I'm not sure how..

> 
> In addition, I successfully used the hmp "pcie_aer_inject_error" in the same conditions.
> The kernel showed relevant print information.

IIRC the AER paths print under all circumstances whereas CXL errors do not, they simply
trigger tracepoints - but you should have seen device resets.

However I span up a test and I think the issue is more straight forward.
The uncorrectable internal error and correctable internal errors are masked on the device.
I thought we changed the default on this in linux but maybe not :(

Hack is fine the relevant device with lspci -tv and then use
setpci -s 0d:00.0 0x208.l=0
to clear all the mask bits for uncorrectable errors.

Note I tested this on a convenient arm64 setup so always possible there is yet
another problem on x86.

Robert / Terry, I tracked down the patch where you enabled this for RCHs and there was
some discussion on walking out on VH as well to enable this, but seems it
never happened. Can you remember why?  Just kicked back for a future occasion?

Jonathan


> 
> Question:
> 1) Is my CXL RAS test operations standard?
> 2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
>    The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem?
> 
> Hope I can get some helps here, any help will be greatly appreciated.
> 
> 
> My qemu command line:
> qemu-system-x86_64 \
> -M q35,nvdimm=on,cxl=on \
> -m 4G \
> -smp 4 \
> -object memory-backend-ram,size=2G,id=mem0 \
> -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
> -object memory-backend-ram,size=2G,id=mem1 \
> -numa node,nodeid=1,cpus=2-3,memdev=mem1 \
> -object memory-backend-ram,size=256M,id=cxl-mem0 \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
> -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
> -hda ../disk/ubuntu_x86_test_new.qcow2 \
> -nographic \
> -qmp tcp:127.0.0.1:4444,server,nowait \
> 
> Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu" 
> Kernel version: 6.8.0-rc6
> 
> My steps in the Qemu qmp:
> 1) telnet 127.0.0.1 4444
> 
> result:
> Trying 127.0.0.1...
> Connected to 127.0.0.1.
> Escape character is '^]'.
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 8}, "package": "v6.2.0-19482-gccfb4fe221"}, "capabilities": ["oob"]}}
> 
> 2) { "execute": "qmp_capabilities" }
> 
> result:
> {"return": {}}
> 
> 3) If inject correctable error:
> { "execute": "cxl-inject-correctable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "type": "physical"
>     } }
> 
> result:
> {"return": {}}
> 
> 3) If inject uncorrectable error:
> { "execute": "cxl-inject-uncorrectable-errors",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-mem0",
>     "errors": [
>         {
>             "type": "cache-address-parity",
>             "header": [ 3, 4]
>         },
>         {
>             "type": "cache-data-parity",
>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>         },
>         {
>             "type": "internal",
>             "header": [ 1, 2, 4]
>         }
>         ]
>   }}
> 
> result:
> {"return": {}}
> {"timestamp": {"seconds": 1709721640, "microseconds": 275345}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-signal"}}
> 
> Many thanks
> Yuquan
> 

