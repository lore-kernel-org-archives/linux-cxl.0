Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5330954F8C;
	Fri,  7 Mar 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314051; cv=none; b=VfTDM0m/bed8NPh1rvins9FPb4smiatWiP4lljfNw3IJKEjXdqWc3OEe0HafjyKqXDqMGvteokd+dA2R1MyemlaKvBMcU1mZAzGPVEc8u2zNEsMJFeorMTCruDsAasZHmNWA5qm5vd7GK0wjMAF4MAt+aTsdNwx2z2Qd8wdEsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314051; c=relaxed/simple;
	bh=+6tLDls9EW0FXKL38bYFqrjcRNcCPuJlju4ebK2g2rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZhlpbHmk32YpxNtQm9kkynH6H0KKfMthlrolhlEJSfb7V0zfvZkUBNfuIrzNJ+s4AA3iHcdjlycik1hVnwToFObXGrjlTg6b4MDTXXe3Y61aoycCI3BV9RuIptB8nFuzNNxyW1j1M8Neq/pGo571m++ozlF4jquzy2Dfy2TTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnL2vxV8pnbl5XBw--.55623S2;
	Fri, 07 Mar 2025 10:20:33 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBXW4fwV8pnU589AA--.4347S2;
	Fri, 07 Mar 2025 10:20:32 +0800 (CST)
Date: Fri, 7 Mar 2025 10:20:31 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8pX786s+1DQIMDy@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8j8bZ5TS+gDV8+M@phytium.com.cn>
 <Z8nWobZXQwhtE1nK@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8nWobZXQwhtE1nK@gourry-fedora-PF4VCD3F>
X-CM-TRANSID:AQAAfwBXW4fwV8pnU589AA--.4347S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWfIrdcBhQBJsZ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGw4xXr1rJrW5Zw4rZr4kXrb_yoW5Gw18pr
	WDKF92kFs8try7CFn2gw42g34FyFWvkFWUJryFgrWUGF98ur1Fqr4rKF1q9Fyxur4UAF1j
	v3yktw13Xa4Y9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Thu, Mar 06, 2025 at 12:08:49PM -0500, Gregory Price wrote:
> On Thu, Mar 06, 2025 at 09:37:49AM +0800, Yuquan Wang wrote:
> > On Wed, Mar 05, 2025 at 05:20:52PM -0500, Gregory Price wrote:
> 
> First, thank you for bringing this up, this is exactly the type of
> ambiguiuty i was hoping others would contribute.  It's difficult to
> figure out if the ACPI tables are "Correct", if there's unimplemented
> features, or we're doing something wrong - because some of this is
> undocumented theory of operation.
> 
Thank you for your patience in replying my questions. :)
> > > ==================
> > > NUMA node creation
> > > ===================
> > > NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
> > > identified at `__init` time, more specifically during `mm_init`.
> > > 
> > > What this means is that the CEDT and SRAT must contain sufficient
> > > `proximity domain` information for linux to identify how many NUMA
> > > nodes are required (and what memory regions to associate with them).
> > > 
> > Condition:
> > 1) A UMA/NUMA system that SRAT is absence, but it keeps CEDT.CFMWS
> > 2）Enable CONFIG_ACPI_NUMA
> > 
> > Results:
> > 1) acpi_numa_init: the fake_pxm will be 0 and send to acpi_parse_cfmws()
> > 2）If dynamically create cxl ram region, the cxl memory would be assigned
> > to node0 rather than a fake new node.
> >
> 
> This is very interesting.  Can I ask a few questions:
> 
> 1) is this real hardware or a VM?
Qemu VM (arm64 virt).
> 2) By `dynamic creation` you mean leveraging cxl-cli (ndctl)?
Yes. After boot, I used "cxl create-region". 
> 2a) Is the BIOS programming decoders, or are you programming the
>     decoder after boot?
Program the decoder after boot. It seems like currently bios for qemu could
not programm cxl both on x86(q35) and arm64(virt). I am trying to find a
cxl-enable bios for qemu virt to do some test.
> 
> 
> > Confusions:
> > 1) Does CXL memory usage require a numa system with SRAT? As you
> > mentioned in SRAT section: 
> > 
> > "This table is technically optional, but for performance information
> > to be enumerated by linux it must be present."
> > 
> > Hence, as I understand it, it seems a bug in kernel.
> >
> 
> It's hard to say if this is a bug yet.  It's either a bug, or your
> system should have an SRAT to describe what the BIOS has done.
> 
> > 2) If it is a bug, could  we forbid this situation by adding fake_pxm
> > check and returning error in acpi_numa_init()?
> > 
> 
> > 3）If not,  maybe we can add some kernel logic to allow create these fake
> > nodes on a system without SRAT?
> > 
> 
> I think we should at least provide a warning (if the SRAT is expected
> but missing) - but lets get some more information first.
> 
> ~Gregory

