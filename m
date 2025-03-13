Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B826988E;
	Thu, 13 Mar 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885257; cv=none; b=NdVYgMFY+DmCvpEnkpFCFrsqAbRWQAVINa1iYzxurgUTZTp9/M77/68RzYL97UWYlLLHI543sDbZhGXzRCqlC23rqhlIFt8P5aUeW9ghlbYVq6UbK2J+pqdC847Mka/ycrEY3ZyuWHjD9wVQf3mF3k203pHjg7RvlyMA5qYQ+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885257; c=relaxed/simple;
	bh=kWvxxqFCNCHuRqIKYiTmNRuek/xx6X2vglTUsnHIO1k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8NS/zDHKvqwfdkOutRGfXeeD+laqeFL3JNbn6qjhUOm1ooMY8z9fy/R5zM7rcjD7L2Fpz1c6aCVrhJ99uP0y/eJtkIJcrY7d1uvBBwOVNZhCWT7pcvFXrNUTtPvYew5RjbheoPHiEYU+qPmmkOcDrmgGFKeJVGMGABzOkDz/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDDFf6bPpz6M4PN;
	Fri, 14 Mar 2025 00:57:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E2FB9140A77;
	Fri, 14 Mar 2025 01:00:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 18:00:52 +0100
Date: Thu, 13 Mar 2025 17:00:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	<lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <20250313170051.0000267e@huawei.com>
In-Reply-To: <Z8sM-W1F6-TIZcGa@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
	<Z8j8bZ5TS+gDV8+M@phytium.com.cn>
	<Z8nWobZXQwhtE1nK@gourry-fedora-PF4VCD3F>
	<Z8pX786s+1DQIMDy@phytium.com.cn>
	<Z8sM-W1F6-TIZcGa@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 7 Mar 2025 10:12:57 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Mar 07, 2025 at 10:20:31AM +0800, Yuquan Wang wrote:
> > > 2a) Is the BIOS programming decoders, or are you programming the
> > >     decoder after boot?  
> > Program the decoder after boot. It seems like currently bios for qemu could
> > not programm cxl both on x86(q35) and arm64(virt). I am trying to find a
> > cxl-enable bios for qemu virt to do some test.  
> 
> What's likely happening here then is that QEMU is not emitting an SRAT
> (either because the logic is missing or by design). 
> 
> From other discussions, this may be the intention of the GenPort work,
> which is intended to have placeholders in the SRAT for the Proximity
> Domains for devices to be initialized later (i.e. dynamically).
> 

For QEMU you need to provide a whole bunch of config to get SRAT / HMAT
etc ( and BIOS never configures the stuff, it's all OS first.

I wrote a slightly pathological test case that should give the general idea
https://elixir.bootlin.com/qemu/v9.2.2/source/tests/qtest/bios-tables-test.c#L1940
It flushed out a few bugs :)

    test_acpi_one(" -machine hmat=on,cxl=on"
                  " -smp 3,sockets=3"
                  " -m 128M,maxmem=384M,slots=2"
                  " -device pcie-root-port,chassis=1,id=pci.1"
                  " -device pci-testdev,bus=pci.1,"
                  "multifunction=on,addr=00.0"
                  " -device pci-testdev,bus=pci.1,addr=00.1"
                  " -device pci-testdev,bus=pci.1,id=gidev,addr=00.2"
                  " -device pxb-cxl,bus_nr=64,bus=pcie.0,id=cxl.1"
                  " -object memory-backend-ram,size=64M,id=ram0"
                  " -object memory-backend-ram,size=64M,id=ram1"
                  " -numa node,nodeid=0,cpus=0,memdev=ram0"
                  " -numa node,nodeid=1"
                  " -object acpi-generic-initiator,id=gi0,pci-dev=gidev,node=1"
                  " -numa node,nodeid=2"
                  " -object acpi-generic-port,id=gp0,pci-bus=cxl.1,node=2"
                  " -numa node,nodeid=3,cpus=1"
                  " -numa node,nodeid=4,memdev=ram1"
                  " -numa node,nodeid=5,cpus=2"
                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
                  "data-type=access-latency,latency=10"
                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=800M"
                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
                  "data-type=access-latency,latency=100"
                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=200M"
                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
                  "data-type=access-latency,latency=100"
                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=200M"
                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
                  "data-type=access-latency,latency=200"
                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=400M"
                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
                  "data-type=access-latency,latency=500"
                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=100M"
                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
                  "data-type=access-latency,latency=50"
                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=400M"
                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
                  "data-type=access-latency,latency=50"
                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=800M"
                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
                  "data-type=access-latency,latency=500"
                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=100M"
                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
                  "data-type=access-latency,latency=20"
                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=400M"
                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
                  "data-type=access-latency,latency=80"
                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=200M"
                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
                  "data-type=access-latency,latency=80"
                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=200M"
                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
                  "data-type=access-latency,latency=20"
                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=400M"
                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
                  "data-type=access-latency,latency=20"
                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=400M"
                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
                  "data-type=access-latency,latency=80"
                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=200M"
                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
                  "data-type=access-latency,latency=80"
                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=200M"
                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
                  "data-type=access-latency,latency=10"
                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
                  "data-type=access-bandwidth,bandwidth=800M",
                  &data);

Jonathan


> ~Gregory
> 

