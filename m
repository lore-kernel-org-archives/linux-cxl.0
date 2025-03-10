Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F105225408;
	Mon, 10 Mar 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603532; cv=none; b=TJD4vQ4A+fj4lKy9Uni/3Mce2lhJxKQmcCw3uLBRM/GrLYqo6O9kHUF1DFQFgKqMGTze12HORfHVXDAPFtGL8NA2HYaC7sbFme5p6SxPGyVK53Aom4fCMOTTW2O2fTuE4kCBdfyLK4gCtDhd9SeA5UCog5FXOvit+Ndz9hiMHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603532; c=relaxed/simple;
	bh=vfcznpiO+5LQe5G67Dh6BaKUSS2Guls6YPJQjsLCV2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/bzQOB0suF40T08/zpIUHMKK7Ok0c5rWRQpTw5ySTnjqp6lDMytUW4ZpovEFyvF7l3AcKyU8A+qmFF9U/3MFb57PftolnquZixVO1eswF5r4p8sAznyHFJrDx6/3Zhk602oBtrAkhTbzx1E59kCne4AmW61f5BHJmjCB20mtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3P6+7ws5n8M9SCA--.19558S2;
	Mon, 10 Mar 2025 18:45:15 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwD394O4ws5nqbhBAA--.4972S2;
	Mon, 10 Mar 2025 18:45:14 +0800 (CST)
Date: Mon, 10 Mar 2025 18:45:12 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z87CuDBMeIcPIWvV@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
X-CM-TRANSID:AQAAfwD394O4ws5nqbhBAA--.4972S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWfN84QD-gACsn
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ArWDAF18ArWftFW3Xw1UWrg_yoW8Kw1fpr
	nxJryxGr4kGryxJr18Zw1rJr1UJw1YkF45Jr18Jr10kw15Cryjvr47tr18Zr9rGryUAF1U
	XrWjqryDtF4DAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> 
> Platform / BIOS / EFI Configuraiton
> ===================================
> ---------------------------------------
> Step 1: BIOS-time hardware programming.
> ---------------------------------------
> 
> I don't want to focus on platform specifics, so really all you need
> to know about this phase for the purpose of MM is that platforms may
> program the CXL device heirarchy and lock the configuration.
> 
This question can be very naive, what's the meaning of 'MM' here?

And since I am not familiar with cxl bios configurations, based on my
understanding of its acpi results, there are roughly two configuration
schemes in my analysis: a) users should enter some configuration
information manually (like region base/size). b) bios could provide a
recommendatory configuration by device information.

Is my understanding right?
> In practice it means you probably can't reconfigure things after boot
> without doing major teardowns of the devices and resetting them -
> assuming the platform doesn't have major quirks that prevent this.
> 
> This has implications for Hotplug, Interleave, and RAS, but we'll
> cover those explicitly elsewhere. Otherwise, if something gets mucked
> up at this stage - complain to your platform / hardware vendor.
> 
> 
> ------------------------------------------------------------------
> Step 2: BIOS / EFI generates the CEDT (CXL Early Detection Table).
> ------------------------------------------------------------------
> 
> This table is responsible for reporting each "CXL Host Bridge" and
> "CXL Fixed Memory Window" present at boot - which enables early boot
> software to manage those devices and the memory capacity presented
> by those devices.
> 
> Example CEDT Entries (truncated) 
>          Subtable Type : 00 [CXL Host Bridge Structure]
>               Reserved : 00
>                 Length : 0020
> Associated host bridge : 00000005
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>               Reserved : 00
>                 Length : 002C
>               Reserved : 00000000
>    Window base address : 000000C050000000
>            Window size : 0000003CA0000000
> 
> If this memory is NOT marked "Special Purpose" by BIOS (next section),
> you should find a matching entry EFI Memory Map and /proc/iomem
> 
> BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable
> /proc/iomem: c050000000-fcefffffff : System RAM
> 

