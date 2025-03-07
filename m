Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214A24113D
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375479; cv=none; b=pE6fnRiuPAh6SnQxb1r7AxMFbWz6/Rd170L9ggaaMZm6NSK1hQQ/utZmvgGYt1WooVvmG9EYwwXowaqBYTZV7YBWl7mRVScM0oqzj94QiJqlpPQk9XH3ITdahqRGuYdwhQEnjKQxYlcDOFEFIHPVFb/vIxEHMFnvl2HzoiDWwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375479; c=relaxed/simple;
	bh=VytaZ+VIP96ZA01ATcBiAkR8BNezYxwbcVOFCJnF3dc=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZvKkpiO/+TcZWQ+hJruVfGDx2TrWEsc6Mv/o1n/9rnI9OwRv7Cgg4RzunUxOQpQ1I7PeYXD2rJAbg+z5QNvH0HqosUG397gZj7HeBnz1Lfsxu6bUPJ/GiOb/NAGycSBaPBy3Q0/h9zQAevIizuXN8uY0Ws9NQfKwrcB2r3rkny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGy1ygW8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGy1ygW8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22349bb8605so43808915ad.0
        for <linux-cxl@vger.kernel.org>; Fri, 07 Mar 2025 11:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741375477; x=1741980277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB7B7ZheQKprIBh7z2McMSM0qhJwQkhqYytweeJ6jPs=;
        b=nGy1ygW8e+9zGND/IuikgmTLdVT3XhwEGSvQekRi38vTG53sbgie4AOu9lyAfMOFu5
         Ja7XfnU3Vs+ela8I1EmZi0mr8mwO0Knf/F1C/6KprFtfqMZ3vpjioAwrkuqd/jt3XZzO
         /LnhmqSE0U2rNb4xeGjOScrWWsPC9r6appPTW3odjyw/2WYcHbUsRB9cVHvCQ2KJ6KWl
         8n0bGYR3lG+AYVqMPOBpenEN8sFtL2K3Otvz4Pi0eqMaM2aQl4txYQMqTkYwWoGXG/jQ
         kMtNwtcj7CrIslhA3WmEUw5G72qerXd6lylm9CoFFpE+HaSS8D3c0Ti8RaoUJOH6XxvO
         e5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375477; x=1741980277;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB7B7ZheQKprIBh7z2McMSM0qhJwQkhqYytweeJ6jPs=;
        b=DkoiSbh8PgoSPLPgZslcB2wjzmFNTmc5BcepFcSGZ+dWF87b3SEXymeF3zDywCdMLN
         Gk4E8OUM7DXos3srxnyIKR7VHlhYu5mAo0CekirYP8Bcj3A8C4kUtHD8ARwLANZJokEx
         pYxSIM/Wsc4M+7777OSgXxRWgYyCUjbxBr7hgtJ9evf24i78xaGCozXAlE2mmX5yBkQw
         h/POUHweZFI/9CfIaf+di4uH0Fw3RZ/cFZUIR3GdHjRmNAOmIh6pF5fmAMLHZaadbMuU
         MABIe3DMt5T1yooeP20Q3+TEBSVQwY5Zk7LTR5r3cCWrjIwY6BKpMSPh35Y2usNW+hjF
         THeQ==
X-Gm-Message-State: AOJu0Ywy0ajkpxJwFiwhxEtPx8eRiv49UTb2Ck9kkWJqMYSPGfvUhRDV
	j9oqaG/1LXnwQLkvvnFW+uRyejA0nxZEDJqkFGJsP3bpym2CGEgUSYlG3g==
X-Gm-Gg: ASbGncsjhKLA6VqoCIXWNPn7sioFV14NeRcFCrrZo8z365GrjnTKUdhff2OzDFJX+en
	znfM2j3GW6MA4ZCGogkqHrRwqCNhqlSEmiHeVjdGn2I+iCRDuxe9DdhKxxRw80Enjh4R0gnq+rT
	iuzW9yLCt4NSnk9+XJfuDy/Ns8fxukrhp2H4d3Yty/VwB1vo2WR2s/XBGy+Bc3E5BMNBOqdpsQl
	gpgDMW4lYxAZrNYEgyWOKDL4z5SaDzMDwaR2dKJPD69WMwZswuvfhBpNK9MhyXt1/F52ciJ+IJb
	rJZpqP8CVl403oKK2Rko/bpCCl5/6TfdQtTat7Q=
X-Google-Smtp-Source: AGHT+IGXv01A3tOxH0fpw0KteGrIw4b/FfPQzludChvwl9LQcgCIXOFzGl6QhxwmHpVOVS5dhDH5Qw==
X-Received: by 2002:a05:6a00:8d0:b0:736:2d84:74da with SMTP id d2e1a72fcca58-736aa9e7465mr6504087b3a.10.1741375477008;
        Fri, 07 Mar 2025 11:24:37 -0800 (PST)
Received: from debian ([2601:646:8f03:9fee:f188:ee28:3170:676a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698538829sm3752747b3a.174.2025.03.07.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:24:36 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 7 Mar 2025 11:24:32 -0800
To: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, fan.ni@samsung.com, anisa.su887@gmail.com
Cc: dave.jiang@intel.com, alison.schofield@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com
Subject: [ISSUE]: cxl create region with one memdev fails when we have more
 than one HBs in the cxl topology setup 
Message-ID: <Z8tH8BeFQ_WMYs5U@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ISSUE]: Create region with one memdev failed when we have 2 HBs in cxl top=
ology setup

I create a cxl topology with 2 HBs like below:
             CFMW
           /    \
        HB0     HB1
         |       |
        RP0     RP1
         |       |
        pmem    ram

qemu command line:

/home/fan/cxl/qemu/build/qemu-system-x86_64 -s  -kernel /home/fan/cxl/linux=
-fixes//arch/x86/boot/bzImage -append "root=3D/dev/sda rw console=3DttyS0,1=
15200 ignore_loglevel nokaslr cxl_acpi.dyndbg=3D+fplm cxl_pci.dyndbg=3D+fpl=
m cxl_core.dyndbg=3D+fplm cxl_mem.dyndbg=3D+fplm cxl_pmem.dyndbg=3D+fplm cx=
l_port.dyndbg=3D+fplm cxl_region.dyndbg=3D+fplm cxl_test.dyndbg=3D+fplm cxl=
_mock.dyndbg=3D+fplm cxl_mock_mem.dyndbg=3D+fplm dax.dyndbg=3D+fplm dax_cxl=
=2Edyndbg=3D+fplm device_dax.dyndbg=3D+fplm" -smp 8 -accel kvm -serial mon:=
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


-----------------
# cxl create-region -m -d decoder0.0 -w 1 mem1 -s 512M -t pmem
cxl region: create_region: region0: set_interleave_ways failed: Invalid arg=
ument
cxl region: cmd_create_region: created 0 regions
-----------------

The reason is for the root decoder, iw =3D 2, while for creating the region=
 as
above, number of ways is 1, which fails the check here:

https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/driver=
s/cxl/core/region.c?h=3Dfixes#n491

-----------------
	if (!is_power_of_2(val / cxld->interleave_ways) ||
	    (val % cxld->interleave_ways)) {
		dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
		return -EINVAL;
	}
-----------------
491		if (!is_power_of_2(val / cxld->interleave_ways) ||
(gdb) n
493			dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
(gdb) p val
$8 =3D 1
(gdb) p cxld->interleave_ways
$9 =3D 2

So how can we create a region with only one memdev when there are more than=
 1 HBs,
but we only want to touch device under one HB?

Or do I miss something here?


#cxl list -vvv

[
  {
    "bus":"root0",
    "provider":"ACPI.CXL",
    "nr_dports":2,
    "dports":[
      {
        "dport":"pci0000:0c",
        "alias":"ACPI0016:01",
        "id":12
      },
      {
        "dport":"pci0000:70",
        "alias":"ACPI0016:00",
        "id":112
      }
    ],
    "ports:root0":[
      {
        "port":"port1",
        "host":"pci0000:70",
        "depth":1,
        "decoders_committed":0,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:70:00.0",
            "id":14
          }
        ],
        "endpoints:port1":[
          {
            "endpoint":"endpoint3",
            "host":"mem0",
            "parent_dport":"0000:70:00.0",
            "depth":2,
            "decoders_committed":0,
            "memdev":{
              "memdev":"mem0",
              "ram_size":536870912,
              "serial":3841,
              "host":"0000:71:00.0",
              "firmware_version":"BWFW VERSION 00",
              "partition_info":{
                "total_size":536870912,
                "volatile_only_size":536870912,
                "persistent_only_size":0,
                "partition_alignment_size":0
              },
              "firmware":{
                "num_slots":2,
                "active_slot":1,
                "online_activate_capable":true,
                "slot_1_version":"BWFW VERSION 0",
                "fw_update_in_progress":false
              }
            },
            "decoders:endpoint3":[
              {
                "decoder":"decoder3.0",
                "interleave_ways":1,
                "state":"disabled"
              },
              {
                "decoder":"decoder3.1",
                "interleave_ways":1,
                "state":"disabled"
              },
              {
                "decoder":"decoder3.2",
                "interleave_ways":1,
                "state":"disabled"
              },
              {
                "decoder":"decoder3.3",
                "interleave_ways":1,
                "state":"disabled"
              }
            ]
          }
        ],
        "decoders:port1":[
          {
            "decoder":"decoder1.0",
            "interleave_ways":1,
            "state":"disabled",
            "nr_targets":1,
            "targets":[
              {
                "target":"0000:70:00.0",
                "position":0,
                "id":14
              }
            ]
          }
        ]
      },
      {
        "port":"port2",
        "host":"pci0000:0c",
        "depth":1,
        "decoders_committed":0,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:0c:00.0",
            "id":13
          }
        ],
        "endpoints:port2":[
          {
            "endpoint":"endpoint4",
            "host":"mem1",
            "parent_dport":"0000:0c:00.0",
            "depth":2,
            "decoders_committed":0,
            "memdev":{
              "memdev":"mem1",
              "pmem_size":536870912,
              "serial":3840,
              "host":"0000:0d:00.0",
              "firmware_version":"BWFW VERSION 00",
              "partition_info":{
                "total_size":536870912,
                "volatile_only_size":0,
                "persistent_only_size":536870912,
                "partition_alignment_size":0
              },
              "firmware":{
                "num_slots":2,
                "active_slot":1,
                "online_activate_capable":true,
                "slot_1_version":"BWFW VERSION 0",
                "fw_update_in_progress":false
              }
            },
            "decoders:endpoint4":[
              {
                "decoder":"decoder4.0",
                "interleave_ways":1,
                "state":"disabled"
              },
              {
                "decoder":"decoder4.1",
                "interleave_ways":1,
                "state":"disabled"
              },
              {
                "decoder":"decoder4.2",
                "interleave_ways":1,
                "state":"disabled"
              },
              {
                "decoder":"decoder4.3",
                "interleave_ways":1,
                "state":"disabled"
              }
            ]
          }
        ],
        "decoders:port2":[
          {
            "decoder":"decoder2.0",
            "interleave_ways":1,
            "state":"disabled",
            "nr_targets":1,
            "targets":[
              {
                "target":"0000:0c:00.0",
                "position":0,
                "id":13
              }
            ]
          }
        ]
      }
    ],
    "decoders:root0":[
      {
        "decoder":"decoder0.0",
        "resource":79725330432,
        "size":4294967296,
        "interleave_ways":2,
        "interleave_granularity":8192,
        "max_available_extent":4294967296,
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "qos_class":0,
        "nr_targets":2,
        "targets":[
          {
            "target":"pci0000:70",
            "alias":"ACPI0016:00",
            "position":1,
            "id":112
          },
          {
            "target":"pci0000:0c",
            "alias":"ACPI0016:01",
            "position":0,
            "id":12
          }
        ]
      }
    ]
  }
]
