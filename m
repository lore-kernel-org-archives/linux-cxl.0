Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE4176ACC
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065342; cv=none; b=guA1hr2i8PdR8PF4ur2Hlw6aZUMc1OoyirkHXvMNAbYf1/FNBgZaQ6k5Tr6KsRsYiuu1j+SHgWXBeQrxNTwBk9B1pZffRoIRGbq+6UOTaD5Hguo9tyqbvVghgkqt1pJFwWYM/SqC+JiQCJKTOuJP9zES/w0+W5il8thELteRJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065342; c=relaxed/simple;
	bh=uHhYbKiY8Ck007+HnIQx38Y7pbFWaEx3Mx3b1RsyrDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW1ovZyPD6pWcgbZr+TR1C12N65qhJkYDbEva9b8q8O23u+3gYqFwt21dpebVQTYZ+jOeL7o3rV9GJaOPT0fgDGLxq4yT2R3gRo9UCQxMq7DfErBfCXh4iisBl+bEDmnqumczhw7p1vY3hfTF+M6XspnPTkao0srWJuNGx9P9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAX+iZnVlhmALA1AA--.20583S2;
	Thu, 30 May 2024 18:35:19 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCXNk1jVlhmvDUBAA--.1788S2;
	Thu, 30 May 2024 18:35:16 +0800 (CST)
Date: Thu, 30 May 2024 18:35:10 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gregory.price@memverge.com>
Cc: lizhijian@fujitsu.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, y-goto@fujitsu.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	fan.ni@samsung.com
Subject: Re: CXL volatile memory: How to restore the previous
 region/Interleave set
Message-ID: <ZlhWXu6l6i2nYL+t@phytium.com.cn>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <ZldaiYTv1fPcGbCs@memverge.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldaiYTv1fPcGbCs@memverge.com>
X-CM-TRANSID:AQAAfwCXNk1jVlhmvDUBAA--.1788S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWZXg2gEVAABsK
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw18uFWxXF48CF47Jr17Awb_yoWrZry8pF
	W3Xay7KFn8GF13Zws7urZ5Wa4qvwsakw4rCryfJry8Cw15CryIvr43K34Ykay8Cr97Wr1Y
	qay0gFn7Wa4DAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, May 29, 2024 at 12:40:41PM -0400, Gregory Price wrote:
> 
> The CFMWS is the BIOS/EFI's mechanism to report the system configuration
> to the Operating System, not the Operating System's mechanism to change
> system configurations (such as interleave).  What you're talking about
> is re-configuring HDM Decoders to interleave devices *presented by* the
> CFMWS to the operating system.
> 
> Confusing, I know. But stick with me.
> 
> 
> 
> The interleave referred to the CFMWS is the BIOS/EFI telling the system
> that memory accesses to this (physicall address) region will be interleaved
> across the set of devices that are backing that region. The operating system
> is responsible for reading these settings and presenting the memory to the
> system accordingly.
> 
> The BIOS for example could configure all devices behind a single CFMW as
> a "Single Device" that interleaves many physical devices, and the OS should
> present it as such.  In this scenario, there is no need to configure an
> interleave region via cxl-cli - the BIOS already did that for you and
> presented all these devices as a single device.  All you need to do is
> online the memory.
> 
Sorry Gregory, here I have a question. According to your description, the 
bios drivers could prepare some interleave cxl region configurations on 
default cxl hardware(SoC) just like we using ndctl-tools in OS run-time
(cxl create-region). 

> Configuring the CFMWS *should* (but may not) manifest as a set of BIOS/EFI
> options that say how to configure a set of CXL devices behind one or more
> host bridges prior to OS boot. This has its limitations. For example, you'd
> need to reboot the system to make changes and hotplugging a memory device
> becomes impossible. The BIOS/EFI would also need to understand when the
> prior configuration is no longer valid - complicated and problematic.
> 
> Additionally, for more dynamic environments (devices behind a switch,
> or a DCD) this more "static" configuration may (read: does) reduce your
> management flexibility.  I.e. hotplug may not be possible.
> 
> 
> 
> Alternatively, the BIOS may configure each device separately, and the
> OS is may create a region that interleaves those devices explicitly by
> programming an HDM decoder.
> 
> In this scenario, the OS could tear down the region, hotplug that device,
> and recreate the region with new settings accordingly. Greater
> management flexibility, but more software/management complexity.
> 
> This requires the OS to recreate the region/interleave set on each
> reboot - and is probably the preferred mechanism for configuring the
> system (if only because hotplug and device failure is not uncommon).
> 
> In this scenario, re-configuration looks a lot like storage mounting.
> The device is either there or it isn't, and the configuration file
> either works or it doesn't.  Alternatively the daemon setting this all
> up is free to try to make auto-configuration decisions.
> 
> 
> 
> 
> (Final note about interleave for completion sake, but not really
> relevant to this discussion)
> 
> Alternatively you could just online each device as a separate region,
> and simply use something like set_mempolicy/numactl to implement
> interleave on a per-task basis.
> 
> 
> > 
> > But, really is that the above scenario is only for persistent memory with LSA.
> > Even if a user configures a new region for volatile memory, and I could not find any specification to
> > tell the new configuration to the Firmware. 
> > 
> > Could you tell me why such interface is not defined in the CXL specification?
> > Is it just because there is no place to store region information for volatile memory?
> >
> > 
> > IMHO, users want to keep previous configuration after reboot even if it is volatile memory.
> > Though users don't concern about contents of volatile memory, they want to keep region/interleave
> > configuration after reboot. Especially, if previous configuration is some years ago, I'll bet
> > users will forget how they configured regions against cxl volatile memory.
> >
> 
> Probably we want some daemon that reconfigures this similar to how we're
> doing it with storage.  You register a preferred configuration given the
> hardware environment that is valid until the hardware changes.
> 
> The OS shouldn't really be telling the firmware to configure itself if
> only because what happens if you unplug a device?
> 
> ~Gregory

