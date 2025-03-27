Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D5A219E0;
	Thu, 27 Mar 2025 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743042079; cv=none; b=m8YwO4Su5h9SbXaTMKh53oLHJY58jPr1P0ksfUfyeT6I+d/P99n9B2SQXFnZHg6zLjFfoOsztDpdY/RmiVtf4j7Fc7qcxiuLG/1MZyAURtlyq9PaEgfkmXWJnjHmLNpCi1xgdjcKGCOCdl1hMe46pLzD2clULu7lTdwb9pOCIag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743042079; c=relaxed/simple;
	bh=oqfxzTWoe11VdH17owZ33eKYWs3EWudKdqHeIIpptZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmXCczvamevw6jdBg4V+ZpnU2iiUW4cKSwJDwo/T+ISvfmojF0wCPFrsq6Be4OaveoJjrZCTDxHa15XqGhjKBUG9cpO+Hus+U44Gr2FkhbM6CNa9Uvx3PzHHF9ygG2RkcnJ1pXQKkk4H71pWU87O9H/YBN0km7QAlnGmNRYApsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnbGgMtuRnrdFqDg--.40964S2;
	Thu, 27 Mar 2025 10:21:00 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCHioYLtuRnSLxWAA--.64S2;
	Thu, 27 Mar 2025 10:21:00 +0800 (CST)
Date: Thu, 27 Mar 2025 10:20:43 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z+S1+wThBGHe888e@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
 <Z+PIoAGgz33R2c3P@phytium.com.cn>
 <Z-P4ulrFQAbJBC_A@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-P4ulrFQAbJBC_A@gourry-fedora-PF4VCD3F>
X-CM-TRANSID:AQAAfwCHioYLtuRnSLxWAA--.64S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWfkXV4AIgATsw
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxArWDKF15ur1kuFy8WFWktFb_yoW5Cw43pF
	yIyFy7Ka93Wr1xJw1kt34DWFWjgw1kCayUXrWDJw1xKr1kXFWrXwsYkryY9348Kas3tr92
	qa98tFyvq3yjyaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, Mar 26, 2025 at 08:53:14AM -0400, Gregory Price wrote:
> On Wed, Mar 26, 2025 at 05:28:00PM +0800, Yuquan Wang wrote:
> > > 
> > > Notice at both the root and the host bridge, the Interleave Ways is 2.
> > > There are two targets at each level.  The host bridge has a granularity
> > > of 512 to capture its parent's ways and granularity (`2*256`).
> > > 
> > > Each decoder is programmed with the total number of targets (4) and the
> > > overall granularity (256B).
> > >
> > 
> > Sorry, I tried to set this topology on Qemu Virt and used:
> > "cxl create-region -d decoder0.0 -t ram -m mem0,mem1,mem2,mem3"
> > 
> > but it failed with:
> > "cxl region: validate_ways: Interleave ways 2 is less than number of memdevs specified: 4"
> > 
> > It seems like the CFMWs IW should be 4?
> >
> 
> It has been a while since i've interacted with QEMU's interleave stuff,
> but IIRC (at least back when I was working on it) most configurations
> had 1 device per host bridge - in which case the CFMWS IW should be 4
> with each of the host bridges described in it.
> 
> I'm not sure you can do multiple devices per host bridge without a
> switch setup.
>
Qemu counld add 'cxl-rp' under a cxl host bridge. Below is my qemu
command:

-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
-device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
-device cxl-type3,bus=root_port0,volatile-memdev=mem2,id=cxl-mem1 \
-device cxl-type3,bus=root_port1,volatile-memdev=mem3,id=cxl-mem2 \
-device pxb-cxl,bus_nr=20,bus=pcie.0,id=cxl.2 \
-device cxl-rp,port=2,bus=cxl.2,id=root_port2,chassis=0,slot=2 \
-device cxl-rp,port=3,bus=cxl.2,id=root_port3,chassis=0,slot=3 \
-device cxl-type3,bus=root_port2,volatile-memdev=mem4,id=cxl-mem3 \
-device cxl-type3,bus=root_port3,volatile-memdev=mem5,id=cxl-mem4 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=2G \

My lspci shows:

-+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
 |           +-01.0  Red Hat, Inc. Virtio network device
 |           +-02.0  Red Hat, Inc. Virtio block device
 |           +-03.0  Red Hat, Inc. QEMU PCIe Expander bridge
 |           \-04.0  Red Hat, Inc. QEMU PCIe Expander bridge
 +-[0000:0c]-+-00.0-[0d]----00.0  Intel Corporation Device 0d93 (CXL)
 |           \-01.0-[0e]----00.0  Intel Corporation Device 0d93 (CXL)
 \-[0000:14]-+-00.0-[15]----00.0  Intel Corporation Device 0d93 (CXL)
             \-01.0-[16]----00.0  Intel Corporation Device 0d93 (CXL)

My cxl list shows:
[
  {
    "memdev":"mem1",
    "ram_size":268435456,
    "serial":0,
    "host":"0000:15:00.0"
  },
  {
    "memdev":"mem0",
    "ram_size":268435456,
    "serial":0,
    "host":"0000:16:00.0"
  },
  {
    "memdev":"mem2",
    "ram_size":268435456,
    "serial":0,
    "host":"0000:0e:00.0"
  },
  {
    "memdev":"mem3",
    "ram_size":268435456,
    "serial":0,
    "host":"0000:0d:00.0"
  }
]

Then:

# cxl create-region -d decoder0.0 -t ram -m mem0,mem1,mem2,mem3
cxl region: validate_ways: Interleave ways 2 is less than number of memdevs specified: 4
cxl region: cmd_create_region: created 0 regions

This case confuesed me :(

Yuquan
> ~Gregory

