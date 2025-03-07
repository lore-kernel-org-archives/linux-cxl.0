Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464772505D4
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379137; cv=none; b=GlPv5UgnJFegit9DcFwph14IRXFlVUKNDhWp2IvOcqDhVAMkmwipj3sYLPcGv/aWg2mosGhCJHZBEMoL6unQD59tHllK/LFsPl6ECyBwHu5Lj0pRMWAPZGesPSjaDLsIBasOxj1VyXCt84yZc2pWVzLK2326L7ufzb84D24+b+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379137; c=relaxed/simple;
	bh=Yok6z+DqdjhowYkogM+mXeXvKNVOSVfRC6PGots6trY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRKljMQE5kVB0wsblmayd0N810SBXDgNsSlM7ncUs+VO8xD8eeD6jVEieoLFgfEUc7a27Dp9mNeqWjdmAI+7kscV9ULVA6uqpwpQobQnLwRA8omtYqk1LsdVOp3fiJ5F/wYpIs+mfjC842d+ifqCt4G4e08RgEv/9rDaP33GSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mi9m4Omt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mi9m4Omt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741379136; x=1772915136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Yok6z+DqdjhowYkogM+mXeXvKNVOSVfRC6PGots6trY=;
  b=mi9m4OmtKb7TpodszyhB0fIOyA2Yb9LX6HoODhu9z9BtZQX615qUsZTc
   aKPm54vyOJFSP/kS+lTl5lz5AmLsJ1YCo/SLu1e0kSd3HqpD2jI1bTW4g
   tpFiv3BtQB3oWVVXkY6yjGQPV8aYlRZRsp23hWd5KgsBxVLkO2aye1Dw8
   aDZ4vdj+x0xFMBJgC/1APr6KPIuHeqmnzZ1IwNCFAC74QuwLJdX/as6+7
   /D0yIs7zhfFNH66pp2UvjtqBRhPoN+9ywU9G+MAVI3uY/qyb/plY1T2WO
   D21HF8x3vXHJA59LscFTJCu8J7d8jaEoLQNorMU7uBUXwoYbcsr+Us1Qn
   w==;
X-CSE-ConnectionGUID: AE/uAZl0TXygspJoAk0DKg==
X-CSE-MsgGUID: GwukX8KnR8mNyiTkLE3JwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42148251"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42148251"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:25:35 -0800
X-CSE-ConnectionGUID: Z/FJDyPcQ1GKjJpRugwcuw==
X-CSE-MsgGUID: dhJ5yHgGQ4qR+Pzq/rEp0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="150221981"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:25:34 -0800
Date: Fri, 7 Mar 2025 12:25:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
	fan.ni@samsung.com, anisa.su887@gmail.com, dave.jiang@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [ISSUE]: cxl create region with one memdev fails when we have
 more than one HBs in the cxl topology setup
Message-ID: <Z8tWPDKXmB4UCmNu@aschofie-mobl2.lan>
References: <Z8tH8BeFQ_WMYs5U@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z8tH8BeFQ_WMYs5U@debian>

On Fri, Mar 07, 2025 at 11:24:32AM -0800, Fan Ni wrote:
> [ISSUE]: Create region with one memdev failed when we have 2 HBs in cxl t=
opology setup
>=20
> I create a cxl topology with 2 HBs like below:
>              CFMW
>            /    \
>         HB0     HB1
>          |       |
>         RP0     RP1
>          |       |
>         pmem    ram
>=20
> qemu command line:
>=20
> /home/fan/cxl/qemu/build/qemu-system-x86_64 -s  -kernel /home/fan/cxl/lin=
ux-fixes//arch/x86/boot/bzImage -append "root=3D/dev/sda rw console=3DttyS0=
,115200 ignore_loglevel nokaslr cxl_acpi.dyndbg=3D+fplm cxl_pci.dyndbg=3D+f=
plm cxl_core.dyndbg=3D+fplm cxl_mem.dyndbg=3D+fplm cxl_pmem.dyndbg=3D+fplm =
cxl_port.dyndbg=3D+fplm cxl_region.dyndbg=3D+fplm cxl_test.dyndbg=3D+fplm c=
xl_mock.dyndbg=3D+fplm cxl_mock_mem.dyndbg=3D+fplm dax.dyndbg=3D+fplm dax_c=
xl.dyndbg=3D+fplm device_dax.dyndbg=3D+fplm" -smp 8 -accel kvm -serial mon:=
stdio  -nographic  -qmp tcp:localhost:4445,server,wait=3Doff -netdev user,i=
d=3Dnetwork0,hostfwd=3Dtcp::2024-:22 -device e1000,netdev=3Dnetwork0  -moni=
tor telnet:127.0.0.1:12346,server,nowait -drive file=3D/home/fan/cxl/images=
/qemu-image.img,index=3D0,media=3Ddisk,format=3Draw -machine q35,cxl=3Don -=
cpu qemu64,mce=3Don -m 8G,maxmem=3D64G,slots=3D8  -virtfs local,path=3D/opt=
/lib/modules,mount_tag=3Dmodshare,security_model=3Dmapped  -virtfs local,pa=
th=3D/home/fan,mount_tag=3Dhomeshare,security_model=3Dmapped -device pxb-cx=
l,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 -device cxl-rp,port=3D13,bus=3Dcxl.1,=
id=3Droot_port13,chassis=3D0,slot=3D2 -object memory-backend-file,id=3Dhmem=
0,share=3Don,mem-path=3D/tmp/host//hmem0.raw,size=3D512M -object memory-bac=
kend-file,id=3Dlsa0,share=3Don,mem-path=3D/tmp/host//lsa0.raw,size=3D2M -de=
vice cxl-type3,bus=3Droot_port13,memdev=3Dhmem0,lsa=3Dlsa0,id=3Dcxl-memdev0=
,sn=3D3840 -device pxb-cxl,bus_nr=3D112,bus=3Dpcie.0,id=3Dcxl.2 -device cxl=
-rp,port=3D14,bus=3Dcxl.2,id=3Droot_port14,chassis=3D0,slot=3D3 -object mem=
ory-backend-file,id=3Dhmem1,share=3Don,mem-path=3D/tmp/host//hmem1.raw,size=
=3D512M -device cxl-type3,bus=3Droot_port14,volatile-memdev=3Dhmem1,id=3Dcx=
l-vmemdev1,sn=3D3841 -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.targets.1=3Dc=
xl.2,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-granularity=3D8K=20
>=20
>=20
> -----------------
> # cxl create-region -m -d decoder0.0 -w 1 mem1 -s 512M -t pmem
> cxl region: create_region: region0: set_interleave_ways failed: Invalid a=
rgument
> cxl region: cmd_create_region: created 0 regions
> -----------------
>=20
> The reason is for the root decoder, iw =3D 2, while for creating the regi=
on as
> above, number of ways is 1, which fails the check here:

Seems like you need to define another CFMWS with interleave_ways =3D 0
and a target list only including the single HB.
That should get you the root decoder you seek.

Otherwise my question is, did you think what you were doing would
work and why?

>=20
> https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/driv=
ers/cxl/core/region.c?h=3Dfixes#n491
>=20
> -----------------
> 	if (!is_power_of_2(val / cxld->interleave_ways) ||
> 	    (val % cxld->interleave_ways)) {
> 		dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
> 		return -EINVAL;
> 	}
> -----------------
> 491		if (!is_power_of_2(val / cxld->interleave_ways) ||
> (gdb) n
> 493			dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
> (gdb) p val
> $8 =3D 1
> (gdb) p cxld->interleave_ways
> $9 =3D 2
>=20
> So how can we create a region with only one memdev when there are more th=
an 1 HBs,
> but we only want to touch device under one HB?
>=20
> Or do I miss something here?
>=20
>=20
> #cxl list -vvv
>=20
> [
>   {
>     "bus":"root0",
>     "provider":"ACPI.CXL",
>     "nr_dports":2,
>     "dports":[
>       {
>         "dport":"pci0000:0c",
>         "alias":"ACPI0016:01",
>         "id":12
>       },
>       {
>         "dport":"pci0000:70",
>         "alias":"ACPI0016:00",
>         "id":112
>       }
>     ],
>     "ports:root0":[
>       {
>         "port":"port1",
>         "host":"pci0000:70",
>         "depth":1,
>         "decoders_committed":0,
>         "nr_dports":1,
>         "dports":[
>           {
>             "dport":"0000:70:00.0",
>             "id":14
>           }
>         ],
>         "endpoints:port1":[
>           {
>             "endpoint":"endpoint3",
>             "host":"mem0",
>             "parent_dport":"0000:70:00.0",
>             "depth":2,
>             "decoders_committed":0,
>             "memdev":{
>               "memdev":"mem0",
>               "ram_size":536870912,
>               "serial":3841,
>               "host":"0000:71:00.0",
>               "firmware_version":"BWFW VERSION 00",
>               "partition_info":{
>                 "total_size":536870912,
>                 "volatile_only_size":536870912,
>                 "persistent_only_size":0,
>                 "partition_alignment_size":0
>               },
>               "firmware":{
>                 "num_slots":2,
>                 "active_slot":1,
>                 "online_activate_capable":true,
>                 "slot_1_version":"BWFW VERSION 0",
>                 "fw_update_in_progress":false
>               }
>             },
>             "decoders:endpoint3":[
>               {
>                 "decoder":"decoder3.0",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               },
>               {
>                 "decoder":"decoder3.1",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               },
>               {
>                 "decoder":"decoder3.2",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               },
>               {
>                 "decoder":"decoder3.3",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               }
>             ]
>           }
>         ],
>         "decoders:port1":[
>           {
>             "decoder":"decoder1.0",
>             "interleave_ways":1,
>             "state":"disabled",
>             "nr_targets":1,
>             "targets":[
>               {
>                 "target":"0000:70:00.0",
>                 "position":0,
>                 "id":14
>               }
>             ]
>           }
>         ]
>       },
>       {
>         "port":"port2",
>         "host":"pci0000:0c",
>         "depth":1,
>         "decoders_committed":0,
>         "nr_dports":1,
>         "dports":[
>           {
>             "dport":"0000:0c:00.0",
>             "id":13
>           }
>         ],
>         "endpoints:port2":[
>           {
>             "endpoint":"endpoint4",
>             "host":"mem1",
>             "parent_dport":"0000:0c:00.0",
>             "depth":2,
>             "decoders_committed":0,
>             "memdev":{
>               "memdev":"mem1",
>               "pmem_size":536870912,
>               "serial":3840,
>               "host":"0000:0d:00.0",
>               "firmware_version":"BWFW VERSION 00",
>               "partition_info":{
>                 "total_size":536870912,
>                 "volatile_only_size":0,
>                 "persistent_only_size":536870912,
>                 "partition_alignment_size":0
>               },
>               "firmware":{
>                 "num_slots":2,
>                 "active_slot":1,
>                 "online_activate_capable":true,
>                 "slot_1_version":"BWFW VERSION 0",
>                 "fw_update_in_progress":false
>               }
>             },
>             "decoders:endpoint4":[
>               {
>                 "decoder":"decoder4.0",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               },
>               {
>                 "decoder":"decoder4.1",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               },
>               {
>                 "decoder":"decoder4.2",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               },
>               {
>                 "decoder":"decoder4.3",
>                 "interleave_ways":1,
>                 "state":"disabled"
>               }
>             ]
>           }
>         ],
>         "decoders:port2":[
>           {
>             "decoder":"decoder2.0",
>             "interleave_ways":1,
>             "state":"disabled",
>             "nr_targets":1,
>             "targets":[
>               {
>                 "target":"0000:0c:00.0",
>                 "position":0,
>                 "id":13
>               }
>             ]
>           }
>         ]
>       }
>     ],
>     "decoders:root0":[
>       {
>         "decoder":"decoder0.0",
>         "resource":79725330432,
>         "size":4294967296,
>         "interleave_ways":2,
>         "interleave_granularity":8192,
>         "max_available_extent":4294967296,
>         "pmem_capable":true,
>         "volatile_capable":true,
>         "accelmem_capable":true,
>         "qos_class":0,
>         "nr_targets":2,
>         "targets":[
>           {
>             "target":"pci0000:70",
>             "alias":"ACPI0016:00",
>             "position":1,
>             "id":112
>           },
>           {
>             "target":"pci0000:0c",
>             "alias":"ACPI0016:01",
>             "position":0,
>             "id":12
>           }
>         ]
>       }
>     ]
>   }
> ]
