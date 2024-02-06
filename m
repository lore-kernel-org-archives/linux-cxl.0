Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB912E1C9
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214646; cv=none; b=bcRg0fhndun77CjVTod4VVu9hA9UW+uYte3N57glyTSiFPDjamWCa1dVGsRxwMltoI7Rcj0nqrQwOlCgxqEu1F2CzmD+NbrIRnl7HwvY7wUIdSnkMib9/iYoHA6auf9EqZ+o+ojUKhNxR7L3UNF04EEjVmw2c3Edfy1m5pKYHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214646; c=relaxed/simple;
	bh=wPgXuYljXmx1H7etGUMHKptxWTYqPPBOwZ8CAYpHuEc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB3hzF5vACLgLaY3uffHIHIVphMZHoXts+u334/FFMFf5RKL10WgGofSsMdNNRBQgOJjFeVI71MofBxmnoHj6/mFXlnmiJ4JEEZ54RwwLlaj7IaCzNbsEGgeadQogM4XsNFI19sG92/e/0SUTlLlVCT1rXRVAUKw1SQkS9mMUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TTfGc3zXvz6D8Z0;
	Tue,  6 Feb 2024 18:13:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 20577140D27;
	Tue,  6 Feb 2024 18:17:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 6 Feb
 2024 10:17:20 +0000
Date: Tue, 6 Feb 2024 10:17:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Cao, =?UTF-8?Q?Quanquan/=E6=9B=B9_=E5=85=A8=E5=85=A8?="
	<caoqq@fujitsu.com>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: Question about a segmentation fault issue when accessing memory
 in a region
Message-ID: <20240206101719.000065bd@Huawei.com>
In-Reply-To: <3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com>
References: <3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:38:31 +0800
"Cao, Quanquan/=E6=9B=B9 =E5=85=A8=E5=85=A8" <caoqq@fujitsu.com> wrote:

> Hi, guys:
>=20
> I tried to create a region on the 2hb+6mem environment.
> Fortunately, the region was created successfully,
> and the system memory can be seen in the system that
> the system memory has increased.
>=20
> When I tried to use the memory on the region, a segfault occurred.
> anyone has idea?

There are some issues with TCG (QEMU emulator) and other parts
of QEMU and using CXL emulated memory as 'normal memory'.

The way I did the interleaving causes problems for parts of QEMU that
assume they can access memory within a page without doing lookups.
There are other problems with the page table walker emulation and
some locking issues.

Short term I'll try to get a solution out that works ok without
any interleave, and then we can look at whether we can enable
some forms of interleave (greater than page granularity).

Trying to solve this in the general case would require some
tricky caching layer to be introduced. Can probably be done but
may not be worth the effort.

Jonathan

>=20
> Environment info:
> os version: fedora 39
> linux version: 6.7-rc5
> qemu version: v8.2.0-rc4
> kvm: off
>=20
> The detailed operation commands are as follows.
> =3D=3D=3D=3D=3D=3D=3D=3D> Before region creation =20
> # numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1
> node 0 size: 1006 MB
> node 0 free: 624 MB
> node 1 cpus: 2 3
> node 1 size: 899 MB
> node 1 free: 694 MB
> node distances:
> node   0   1
>    0:  10  20
>    1:  20  10
>=20
> # free -h
>                 total        used        free      shared  buff/cache=20
> available
> Mem:           1.9Gi       448Mi       1.3Gi       1.1Mi       330Mi=20
>    1.4Gi
> Swap:          1.9Gi          0B       1.9Gi
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D> create a new region =20
> # echo online_movable > /sys/devices/system/memory/auto_online_blocks
> # cxl list -M -P -D -T -E -u
> [
>    {
>      "ports":[
>        {
>          "port":"port1",
>          "host":"pci0000:20",
>          "depth":1,
>          "nr_dports":2,
>          "dports":[
>            {
>              "dport":"0000:20:00.0",
>              "id":"0"
>            },
>            {
>              "dport":"0000:20:01.0",
>              "id":"0x1"
>            }
>          ],
>          "endpoints:port1":[
>            {
>              "endpoint":"endpoint5",
>              "host":"mem1",
>              "parent_dport":"0000:20:01.0",
>              "depth":2,
>              "memdev":{
>                "memdev":"mem1",
>                "ram_size":"256.00 MiB (268.44 MB)",
>                "serial":"0",
>                "host":"0000:22:00.0"
>              }
>            },
>            {
>              "endpoint":"endpoint4",
>              "host":"mem0",
>              "parent_dport":"0000:20:00.0",
>              "depth":2,
>              "memdev":{
>                "memdev":"mem0",
>                "ram_size":"256.00 MiB (268.44 MB)",
>                "serial":"0",
>                "host":"0000:21:00.0"
>              }
>            }
>          ]
>        },
>        {
>          "port":"port3",
>          "host":"pci0000:0c",
>          "depth":1,
>          "nr_dports":2,
>          "dports":[
>            {
>              "dport":"0000:0c:00.0",
>              "id":"0"
>            },
>            {
>              "dport":"0000:0c:01.0",
>              "id":"0x1"
>            }
>          ],
>          "endpoints:port3":[
>            {
>              "endpoint":"endpoint7",
>              "host":"mem3",
>              "parent_dport":"0000:0c:00.0",
>              "depth":2,
>              "memdev":{
>                "memdev":"mem3",
>                "ram_size":"256.00 MiB (268.44 MB)",
>                "serial":"0",
>                "host":"0000:0d:00.0"
>              }
>            },
>            {
>              "endpoint":"endpoint9",
>              "host":"mem5",
>              "parent_dport":"0000:0c:01.0",
>              "depth":2,
>              "memdev":{
>                "memdev":"mem5",
>                "ram_size":"256.00 MiB (268.44 MB)",
>                "serial":"0",
>                "host":"0000:0e:00.0"
>              }
>            }
>          ]
>        },
>        {
>          "port":"port2",
>          "host":"pci0000:16",
>          "depth":1,
>          "nr_dports":2,
>          "dports":[
>            {
>              "dport":"0000:16:00.0",
>              "id":"0"
>            },
>            {
>              "dport":"0000:16:01.0",
>              "id":"0x1"
>            }
>          ],
>          "endpoints:port2":[
>            {
>              "endpoint":"endpoint6",
>              "host":"mem2",
>              "parent_dport":"0000:16:01.0",
>              "depth":2,
>              "memdev":{
>                "memdev":"mem2",
>                "ram_size":"256.00 MiB (268.44 MB)",
>                "serial":"0",
>                "host":"0000:18:00.0"
>              }
>            },
>            {
>              "endpoint":"endpoint8",
>              "host":"mem4",
>              "parent_dport":"0000:16:00.0",
>              "depth":2,
>              "memdev":{
>                "memdev":"mem4",
>                "ram_size":"256.00 MiB (268.44 MB)",
>                "serial":"0",
>                "host":"0000:17:00.0"
>              }
>            }
>          ]
>        }
>      ]
>    },
>    {
>      "root decoders":[
>        {
>          "decoder":"decoder0.0",
>          "resource":"0x750000000",
>          "size":"4.00 GiB (4.29 GB)",
>          "interleave_ways":3,
>          "interleave_granularity":4096,
>          "max_available_extent":"4.00 GiB (4.29 GB)",
>          "pmem_capable":true,
>          "volatile_capable":true,
>          "accelmem_capable":true,
>          "nr_targets":3,
>          "targets":[
>            {
>              "target":"pci0000:20",
>              "alias":"ACPI0016:00",
>              "position":2,
>              "id":"0x20"
>            },
>            {
>              "target":"pci0000:16",
>              "alias":"ACPI0016:01",
>              "position":1,
>              "id":"0x16"
>            },
>            {
>              "target":"pci0000:0c",
>              "alias":"ACPI0016:02",
>              "position":0,
>              "id":"0xc"
>            }
>          ]
>        }
>      ]
>    }
> ]
> # cxl create-region -t ram -d decoder0.0 -m mem3 mem2 mem1 mem5 mem4 mem0
> {
>    "region":"region0",
>    "resource":"0x750000000",
>    "size":"1536.00 MiB (1610.61 MB)",
>    "type":"ram",
>    "interleave_ways":6,
>    "interleave_granularity":4096,
>    "decode_state":"commit",
>    "mappings":[
>      {
>        "position":5,
>        "memdev":"mem0",
>        "decoder":"decoder4.0"
>      },
>      {
>        "position":4,
>        "memdev":"mem4",
>        "decoder":"decoder8.0"
>      },
>      {
>        "position":3,
>        "memdev":"mem5",
>        "decoder":"decoder9.0"
>      },
>      {
>        "position":2,
>        "memdev":"mem1",
>        "decoder":"decoder5.0"
>      },
>      {
>        "position":1,
>        "memdev":"mem2",
>        "decoder":"decoder6.0"
>      },
>      {
>        "position":0,
>        "memdev":"mem3",
>        "decoder":"decoder7.0"
>      }
>    ]
> }
> cxl region: cmd_create_region: created 1 region
>=20
> =3D=3D=3D> After region creation =20
> # numactl -H
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: 1006 MB
> node 0 free: 736 MB
> node 1 cpus: 2 3
> node 1 size: 899 MB
> node 1 free: 548 MB
> node 2 cpus:
> node 2 size: 1536 MB             <-- new numa node was create
> node 2 free: 1536 MB
> node distances:
> node   0   1   2
>    0:  10  20  20
>    1:  20  10  20
>    2:  20  20  10
>=20
> # free -h          <-- System memory increased
>                 total        used        free      shared  buff/cache=20
> available
> Mem:           3.4Gi       504Mi       2.8Gi       1.1Mi       338Mi=20
>    2.9Gi
> Swap:          1.9Gi          0B       1.9Gi
>=20
> # numactl --membind=3D2 ls
> Segmentation fault (core dumped)
>=20
> # dmesg
> [  310.119439] show_signal_msg: 20 callbacks suppressed
> [  310.119499] ls[1153]: segfault at 1c454 ip 00007fb4cf771523 sp=20
> 00007fff57753fe0 error 4 in ld-linux-x86-64.so.2[7fb4cf753000+27000]=20
> likely on CPU 2 (core 0, socket 2)
> [  310.350803] Code: 01 42 08 48 8b bd 98 fd ff ff 48 8b 57 70 48 85 d2=20
> 74 04 48 01 42 08 48 8b bd 98 fd ff ff 48 8b 97 60 01 00 00 48 85 d2 74=20
> 04 <48> 01 42 08 48 8b bd 98 fd ff ff 48 8b 8f f8 00 00 00 48 85 c9 74
>=20

