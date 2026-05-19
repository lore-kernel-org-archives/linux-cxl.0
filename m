Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE681F4C8E
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201193; cv=none; b=qJNM5FOL2XxSGYL6/vq9rteChfcgyd8UDAEzxTUFaWs5g/cwVi6hr5ldJNagmKv19v3iDrMIQI80OkdEo57+eOg3kDEbAEGnbZrbK6y4XTl8D8MYzKvZDX7rGPVWSwEaspKrL+TkJwzP3Bz1qBt7xfRaoTIxIl5JGttVAWTvKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201193; c=relaxed/simple;
	bh=ShqnucnjtvqD8HwQbqs3PVD/RXRFj1v1T0W39Rp9Qf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKtGAQtywIyGAKjSFIUsy9i5geoPLH5PUO/MrW1jIYeFsaHOKMbhxrHxRlWPxzmIlfOyIg6U0mnrNi4YKJSp9zu0RbSKyGGp83a1RKxIWrWglgDTmG5hcLccugx9qbHwVgHRvwX4NligKrr1y6MXEWnLDWKu2+2a2wkJj/Z0u4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3PyKAqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3PyKAqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6C4C2BCB8;
	Tue, 19 May 2026 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779201192;
	bh=ShqnucnjtvqD8HwQbqs3PVD/RXRFj1v1T0W39Rp9Qf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n3PyKAqyu4S/tkASEhK27neO628FS+8gYRxvAUCUvoghdzoIx9lNeVGTotdo2HWT5
	 ymVTOcNYfW6vivEqyB6paZwk+hyRLnVZg+rbFiGAFeP94GmJRM4/X83aKVq98sRNNn
	 5nw9oT+SP5Fxy9iW4NbTtl3XGlVNoB4J8agXG3YKkxWuTW2ZGCgIezVybcMR+6ukNw
	 l9rnR77aAeVovH7b1h6DlWKC+Wbgnnl0OS3ZufCfZrPGhP5pzG6Qc7lglwuyex/eWI
	 Atss77q+yGtgsAZJSTiQ8RojAnUUAda0HCkc0NKv23gbOfUb7pk6CtpWAMwdP8nSCV
	 z98e2ImQUzXHg==
Date: Tue, 19 May 2026 15:33:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 01/10] docs: Add documentation for
 cxl-vcs-switch
Message-ID: <20260519153308.4626e491@jic23-huawei>
In-Reply-To: <20260429135717.3048713-2-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
	<20260429135717.3048713-2-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 14:48:35 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> Signed-off-by: Joshua Lant <joshualant@gmail.com>
Hi Joshua,

Sorry it's taken me a while to get to this!  I blame to much activity
on other open source projects! :)

I've mused in the past on how to do the command lines for these.
So some thoughts are based on that - feel free to argue why we
the structure you have here works better.

When I get through the series I may well change my mind on some
of what follows ;)


> ---
>  docs/system/devices/cxl.rst | 90 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 32b1b5d773..9e8452e576 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -119,11 +119,11 @@ and associated component register access via PCI bars.
>  CXL Switch
>  ~~~~~~~~~~
>  Here we consider a simple CXL switch with only a single
> -virtual hierarchy. Whilst more complex devices exist, their
> -visibility to a particular host is generally the same as for
> -a simple switch design. Hosts often have no awareness
> -of complex rerouting and device pooling, they simply see
> -devices being hot added or hot removed.
> +virtual hierarchy. Whilst more complex devices exist (see VCS
> +Switching below), their visibility to a particular host is
> +generally the same as for a simple switch design. Hosts often
> +have no awareness of complex rerouting and device pooling,
> +they simply see devices being hot added or hot removed.
>  
>  A CXL switch has a similar architecture to those in PCIe,
>  with a single upstream port, internal PCI bus and multiple
> @@ -467,6 +467,86 @@ Example configuration:
>  Guest OS communication with the MCTP CCI can then be established using standard
>  MCTP configuration tools.
>  
> +CXL Multi-VCS Switching
> +-----------------------
> +
> +The cxl-vcs-switch object allows for a Fabric Manager to dynamically reconfigure
> +the switching within a multi-upstream port CXL/PCIe topology, This moves beyond
> +the static switching configuration described above. The use of vcs=X on an
> +endpoint device indicates that it should be hidden from guests at boot. 

That bit seems rather unintuitive.  EPs shouldn't really be involved in this
at all. I guess you are using them as a proxy for a physical downstream port?
Interesting idea if a bit non intuitive. I wonder if we can put in an explicit
physical DSP device in. When linked it just proxies the vPPD.

Maybe we can get away without that but it leaves us with no physical port hotplug
as we can't connect an empty physical downstream port to a VCS.

> Each
> +upstream port with vcs=X set will conceptually become an upstream PPB. Any
> +downstream port that is connected to an upstream port with vcs=X set will
> +automatically become a vPPB for that VCS. The overall cxl-virtual-switch has a
Neat not to have to set it for the DSPs, but I think we will need them to
grow new functionality so maybe a different device type is good.

> +single CCI mailbox used for config/status of all ports within the switch.

Need to support both MCTP and switch-cci but that should be fine.

> +Setting local-fm=true indicates that this QEMU instance has the CCI mailbox
> +attached. Setting it false will create listeners for commands from a remote
> +QEMU process (yet to be implemented).

Nice but make that the default for now (And drop the parameter).
Absence of a connected CCI might be sufficient though that's a bit ugly
to check.

> +
> +An example of how the topology is described on the CLI is shown below:
> +
> +  -object cxl-vcs-switch,id=vcs0,usp-ppbs=2,dsp-ppbs=4,local-fm=true \
Interesting.  I'd kind of like it to be a device, but it has no presence
on any bus in of itself (arguably it is on a whole load of them). So maybe not.

> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \

Small side note - avoid the passthrough trick. It means a bunch of code
paths aren't exercised and has hidden various OS bugs.

> +  -device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
> +  -device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
> +  -device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on,vcs=vcs0,usppb=0 \
> +  -device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.0,multifunction=on,vcs=vcs0,usppb=1 \

How can we have two upstream ports in a single vcs?  To me those are separate VCSs
where a VCS is normally a tree topology below a given USP.

I think we have a terminology problem.  If I read this right you are using VCS
to mean the whole physical switch?  Been a little while but I don't think
that corresponds at all to it's meaning in the CXL Spec. Your VCS0/1 below
are right.



> +  -device cxl-switch-mailbox-cci,bus=root_port1,addr=0.3,target=vcs0 \
> +  -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=vcs0 \
> +  -device cxl-downstream,port=0,bus=us0,id=dsp0,slot=3 \
> +  -device cxl-downstream,port=1,bus=us0,id=dsp1,slot=4 \
> +  -device cxl-downstream,port=0,bus=us1,id=dsp2,slot=7 \
> +  -device cxl-downstream,port=1,bus=us1,id=dsp3,slot=8 \
Ok. So these only know they are virtual because they are connected to a virtual USP.
Might be enough - or we might want to make that more explicit via
a new device type.

> +  -device cxl-type3,persistent-memdev=cxl-mem1,id=cxl-ep1,lsa=cxl-lsa1,sn=99,vcs=vcs0,dsppb=0 \
> +  -device cxl-type3,persistent-memdev=cxl-mem2,id=cxl-ep2,lsa=cxl-lsa2,sn=100,vcs=vcs0,dsppb=1 \
> +  -device cxl-type3,persistent-memdev=cxl-mem3,id=cxl-ep3,lsa=cxl-lsa3,sn=101,vcs=vcs0,dsppb=2 \
> +  -device cxl-type3,persistent-memdev=cxl-mem4,id=cxl-ep4,lsa=cxl-lsa4,sn=102,vcs=vcs0,dsppb=3 \
This I mention above. I 'think' you are using the dsppb to instantiate something that is pretending
to be a the physical DSP.
I haven't yet read thee series, but gut feeling is that will make the querying of link
properties etc rather different from the normal case.

> +  -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G
> +
> +Example topology involving VCS switching::
> +
> +               +--------------------+  +--------------------+
> +               |   Host Bridge 0    |  |   Host Bridge 1    |
> +               +----------+---------+  +----------+---------+
> +    +-------+             |                       |
> +    | MCTP  |             |                       |
> +    | USB/  |  +----------+---------+  +----------+---------+
> +    | I2C   |  |    Root Port 0     |  |    Root Port 1     |
> +    +-----+-+  +----------+---------+  +----------+---------+
> +          |               |                       |
> +          |               |                       |
> +   +------|---------------+-----------------------+-----------------------+
> +   |    +-+--------+      |  cxl-vcs-switch (vcs0)|                       |
> +   | +--| CCI MBOX |---*  |                       |                       |
> +   | |  +----------+      |                       |                       |
> +   | |  +-----------------+--------+      +-------+------------------+    |
> +   | +--+                 |   VCS0 |  *---+       |             VCS1 |    |
> +   |    | +---------------+------+ |      | +-----+----------------+ |    |
> +   |    | |                      | |      | |                      | |    |
> +   |    | |        USP 0         | |      | |        USP 1         | |    |
> +   |    | |                      | |      | |                      | |    |
> +   |    | +----+------------+----+ |      | +----+------------+----+ |    |
> +   |    |      |            |      |      |      |            |      |    |
> +   |    | +----+----+  +----+----+ |      | +----+----+  +----+----+ |    |
> +   |    | |  DSP 0  |  |  DSP 1  | |      | |  DSP 2  |  |  DSP 3  | |    |
> +   |    | |(vPPB 0) |  |(vPPB 1) | |      | |(vPPB 0) |  |(vPPB 1) | |    |
> +   |    | |         |  |         | |      | |         |  |         | |    |
> +   |    | +---------+  +---------+ |      | +---------+  +----+----+ |    |
> +   |    +--------------------------+      +-------------------+------+    |
> +   |                                                          |           |
> +   |           +----------------------------------------------+           |
> +   |           |                                                          |
> +   |           |            -                    -            -           |
> +   +-----------|------------|--------------------|------------|-----------+
> +               |            |                    |            |
> +          +---------+  +---------+          +---------+  +---------+
> +          |CXL/PCIe |  |CXL/PCIe |          |CXL/PCIe |  |CXL/PCIe |
> +          |  EP 0   |  |  EP 1   |          |  EP 2   |  |  EP 3   |
> +          | (PPB0)  |  | (PPB1)  |          | (PPB2)  |  | (PPB3)  |
> +          +---------+  +---------+          +---------+  +---------+
> +                 PPB0 Bound to VCS1, vPPB1. Others unbound...
> +
Good to have the diagram as makes it easier to discuss.  

What you have here is a bit of a hack because only some entities created
exist in the command line - the others are spun up implicitly.  I suspect
we really want to make them explicit.  The one thing I never looked into in
the following is how hard it would be to poke a vDSP in front of a physical
DSP and basically proxy stuff through or not.  Some stuff will be programmed
at boot (windows etc for hotplug later) but other stuff will fire in the hotplug
flow on an attach of a physical port. Will need some care and stitching up
memory regions across the boundary.

The command line I'd be looking at for this as a target (feel free to shoot
at it) would be something like (I went with one PXB - but need to test both options). 
Note some of this is probably garbage as I haven't checked parameters are right.
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 \
 -device cxl-rp,bus,cxl.0,id=root_port1...
 -device cxl-rp,bus,cxl.0,id=root_port2..
 -device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on,virtual=on \
 -device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.0,virtual=on \

#note I extended current target to a list
 -device cxl-virtual-downstream,vport=0,bus=us0,id=vppb0 \
 -device cxl-virtual-downstream,vport=1,bus=us0,id=vppb0 \
 -device cxl-virtual-downstream,vport=2,bus=us0,id=vppb0 \
 -device cxl-virtual-downstream,vport=0,bus=us1,id=vppb0 \
 -device cxl-virtual-downstream,vport=1,bus=us1,id=vppb0 \
 -device cxl-virtual-downstream,vport=2,bus=us1,id=vppb0 \
# Note more virtual ports than physical - likely common situation.
 -object cxl-switch,usps.0=usp0,usps.1=usp1,id=vsw0 \
#list of usps so we can navigate downwards from this.
 -device cxl-switch-mailbox-cci,id=swcci0,bus=root_por1,multifunction=on,target=vsw0\
# Maybe hang the unconnected physical dsps on a bus created by the cxl-switch?
 -device cxl-downstream,port=0,bus=vsw0,id=dsp0,slot=3 \
 -device cxl-downstream,port=1,bus=vsw0,id=dsp1,slot=4 \
 -device cxl-downstream,port=2,bus=vsw0,id=dsp2,slot=7 \
 -device cxl-downstream,port=3,bus=vsw0,id=dsp3,slot=8 \
#ideally a device but need to think where to hang it.
 -device cxl-type3,persistent-memdev=cxl-mem1,id=cxl-ep1,lsa=cxl-lsa1,sn=99,bus=dsp0 \
 -device cxl-type3,persistent-memdev=cxl-mem2,id=cxl-ep2,lsa=cxl-lsa2,sn=100,bus=dsp1 \
 -device cxl-type3,persistent-memdev=cxl-mem3,id=cxl-ep3,lsa=cxl-lsa3,sn=101,bus=dsp2 \
#note not all DSPs have anything on them.

Few reasons for this structure.
1) The unconnected physical port - we want to make sure physical hotplug works both
   when not associated with a VCS and when it is.
2) We need to be able to talk to EPs via FM interfaces when they aren't connected
   Given we have to make that look like PCI, let's make it PCI.  I'm not sure how
   much hackery that will take as we'll need to do some level of enumeration from
   the the switch controller.  Only need that once we want to do more than check
   training etc though - so maybe job for another day.  In theory we can do everything
   with devices in that state (be it slowly) so would need all the addresses programmed
   etc. Not as general as current discussions on enumerating full PCI bus in QEMU as
   all direct connect.

Anyhow it's fiddly with this scheme but I think a little more general
than your current one and closer representation of the hardware which will
matter as we add all the introspection stuff etc in the FMAPI.

Jonathan



> +
>  References
>  ----------
>  

