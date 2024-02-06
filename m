Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832881292F4
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205129; cv=none; b=qVf0AN/PodF/odRIYKPPh3+yaVN8iKT/oE96eqkceddShOvDCJKz9bmA1uvrDkdVJzeYdIN7HH8UjAxtj/WCVLtWo6K/rAP6511jPUo+4qgG30MYqDUX3lrunBCw4sPzQGJkZydSgil7BaPMKPkqdN86JdKZQ+FOL1T7+daIXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205129; c=relaxed/simple;
	bh=s3mQ0vWdaBkvqua2LAbsQyck9Md7nqljVbhvzkd9eQs=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=V1fOUN4Pdm3iFyO/dJBJpU0WN1gMfo6Htx7q6g1HckFca39C5Gc40veIvgGkzL0CmCDFL4hM/4/xuzvWnWHJq5eEzZE70F7wInRM8D2nKoKHsCIaEi56n/52UYGqX3uiKopG90BBFkGxK/s+oLr2Vf32BI7cx1GMqx2CvaKujAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aue65FSf; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aue65FSf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707205127; x=1738741127;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=s3mQ0vWdaBkvqua2LAbsQyck9Md7nqljVbhvzkd9eQs=;
  b=aue65FSf7msfK67n+XB5dCvqUAz8kQl9SJ8xY7dNSAxqRu8PhTjwGLTN
   hCYFxKwXBvC09Qik/3XGS0840ifYKj3F74MLJidhhdcBNNO5HRkITGBJl
   KrDRVGo+8hgtQX5W6pt/4tXGldOfEoM9Z4c/6+4BuSmYE8riGDiQeasKJ
   xcM3c7wzdxb7ldUNk0b2sU3zvtSdEnXs/04R6YwEx5Fwv9DXwBGjitQ0I
   7w+WiexQBLgxvJYEa51tQKyfqbSw6Y71E87gQSKvoBPKQNptFe4jhFI+a
   er6PqChD7wU7Kgh8oy5vv5H/GRH7QrNAHbLjPWOtqlAulwqeNyMfxHTTu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="127929940"
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="127929940"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 16:38:37 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B100D1F3C6B
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 16:38:34 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DC58926947E
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 16:38:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0A41D200936AC
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 16:38:33 +0900 (JST)
Received: from [10.167.220.145] (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 57D2F1A006A;
	Tue,  6 Feb 2024 15:38:32 +0800 (CST)
Message-ID: <3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com>
Date: Tue, 6 Feb 2024 15:38:31 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Question about a segmentation fault issue when accessing memory in a
 region
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28170.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28170.005
X-TMASE-Result: 10--17.316100-10.000000
X-TMASE-MatchedRID: T3hsd5K8wICGYAKJjm5IPXV7tdtvoiba2FA7wK9mP9ccolHT5C7WMgim
	Mt6TSXWlKzFPIYHt94IueHfWbrIXoO8QljqNvuG6zfqlpbtmcWgyLlxWhS9T9pfHgnfL4gdUXzw
	oVYXbtz6/hOxDurespkMEJ9maChY/wwX0o7eolMDHsEljqux9nRZSD+Gbjz3Ib3Wpj9NSXKyMnZ
	m8tXkF+7aMC2XmTXUNgFK2nmPCAnlNfs8n85Te8oMbH85DUZXy2KDPNsqphTL6C0ePs7A07QKmA
	RN5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi, guys:

I tried to create a region on the 2hb+6mem environment.
Fortunately, the region was created successfully,
and the system memory can be seen in the system that
the system memory has increased.

When I tried to use the memory on the region, a segfault occurred.
anyone has idea?

Environment info:
os version: fedora 39
linux version: 6.7-rc5
qemu version: v8.2.0-rc4
kvm: off

The detailed operation commands are as follows.
========> Before region creation
# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1
node 0 size: 1006 MB
node 0 free: 624 MB
node 1 cpus: 2 3
node 1 size: 899 MB
node 1 free: 694 MB
node distances:
node   0   1
   0:  10  20
   1:  20  10

# free -h
                total        used        free      shared  buff/cache 
available
Mem:           1.9Gi       448Mi       1.3Gi       1.1Mi       330Mi 
   1.4Gi
Swap:          1.9Gi          0B       1.9Gi

========> create a new region
# echo online_movable > /sys/devices/system/memory/auto_online_blocks
# cxl list -M -P -D -T -E -u
[
   {
     "ports":[
       {
         "port":"port1",
         "host":"pci0000:20",
         "depth":1,
         "nr_dports":2,
         "dports":[
           {
             "dport":"0000:20:00.0",
             "id":"0"
           },
           {
             "dport":"0000:20:01.0",
             "id":"0x1"
           }
         ],
         "endpoints:port1":[
           {
             "endpoint":"endpoint5",
             "host":"mem1",
             "parent_dport":"0000:20:01.0",
             "depth":2,
             "memdev":{
               "memdev":"mem1",
               "ram_size":"256.00 MiB (268.44 MB)",
               "serial":"0",
               "host":"0000:22:00.0"
             }
           },
           {
             "endpoint":"endpoint4",
             "host":"mem0",
             "parent_dport":"0000:20:00.0",
             "depth":2,
             "memdev":{
               "memdev":"mem0",
               "ram_size":"256.00 MiB (268.44 MB)",
               "serial":"0",
               "host":"0000:21:00.0"
             }
           }
         ]
       },
       {
         "port":"port3",
         "host":"pci0000:0c",
         "depth":1,
         "nr_dports":2,
         "dports":[
           {
             "dport":"0000:0c:00.0",
             "id":"0"
           },
           {
             "dport":"0000:0c:01.0",
             "id":"0x1"
           }
         ],
         "endpoints:port3":[
           {
             "endpoint":"endpoint7",
             "host":"mem3",
             "parent_dport":"0000:0c:00.0",
             "depth":2,
             "memdev":{
               "memdev":"mem3",
               "ram_size":"256.00 MiB (268.44 MB)",
               "serial":"0",
               "host":"0000:0d:00.0"
             }
           },
           {
             "endpoint":"endpoint9",
             "host":"mem5",
             "parent_dport":"0000:0c:01.0",
             "depth":2,
             "memdev":{
               "memdev":"mem5",
               "ram_size":"256.00 MiB (268.44 MB)",
               "serial":"0",
               "host":"0000:0e:00.0"
             }
           }
         ]
       },
       {
         "port":"port2",
         "host":"pci0000:16",
         "depth":1,
         "nr_dports":2,
         "dports":[
           {
             "dport":"0000:16:00.0",
             "id":"0"
           },
           {
             "dport":"0000:16:01.0",
             "id":"0x1"
           }
         ],
         "endpoints:port2":[
           {
             "endpoint":"endpoint6",
             "host":"mem2",
             "parent_dport":"0000:16:01.0",
             "depth":2,
             "memdev":{
               "memdev":"mem2",
               "ram_size":"256.00 MiB (268.44 MB)",
               "serial":"0",
               "host":"0000:18:00.0"
             }
           },
           {
             "endpoint":"endpoint8",
             "host":"mem4",
             "parent_dport":"0000:16:00.0",
             "depth":2,
             "memdev":{
               "memdev":"mem4",
               "ram_size":"256.00 MiB (268.44 MB)",
               "serial":"0",
               "host":"0000:17:00.0"
             }
           }
         ]
       }
     ]
   },
   {
     "root decoders":[
       {
         "decoder":"decoder0.0",
         "resource":"0x750000000",
         "size":"4.00 GiB (4.29 GB)",
         "interleave_ways":3,
         "interleave_granularity":4096,
         "max_available_extent":"4.00 GiB (4.29 GB)",
         "pmem_capable":true,
         "volatile_capable":true,
         "accelmem_capable":true,
         "nr_targets":3,
         "targets":[
           {
             "target":"pci0000:20",
             "alias":"ACPI0016:00",
             "position":2,
             "id":"0x20"
           },
           {
             "target":"pci0000:16",
             "alias":"ACPI0016:01",
             "position":1,
             "id":"0x16"
           },
           {
             "target":"pci0000:0c",
             "alias":"ACPI0016:02",
             "position":0,
             "id":"0xc"
           }
         ]
       }
     ]
   }
]
# cxl create-region -t ram -d decoder0.0 -m mem3 mem2 mem1 mem5 mem4 mem0
{
   "region":"region0",
   "resource":"0x750000000",
   "size":"1536.00 MiB (1610.61 MB)",
   "type":"ram",
   "interleave_ways":6,
   "interleave_granularity":4096,
   "decode_state":"commit",
   "mappings":[
     {
       "position":5,
       "memdev":"mem0",
       "decoder":"decoder4.0"
     },
     {
       "position":4,
       "memdev":"mem4",
       "decoder":"decoder8.0"
     },
     {
       "position":3,
       "memdev":"mem5",
       "decoder":"decoder9.0"
     },
     {
       "position":2,
       "memdev":"mem1",
       "decoder":"decoder5.0"
     },
     {
       "position":1,
       "memdev":"mem2",
       "decoder":"decoder6.0"
     },
     {
       "position":0,
       "memdev":"mem3",
       "decoder":"decoder7.0"
     }
   ]
}
cxl region: cmd_create_region: created 1 region

===> After region creation
# numactl -H
available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: 1006 MB
node 0 free: 736 MB
node 1 cpus: 2 3
node 1 size: 899 MB
node 1 free: 548 MB
node 2 cpus:
node 2 size: 1536 MB             <-- new numa node was create
node 2 free: 1536 MB
node distances:
node   0   1   2
   0:  10  20  20
   1:  20  10  20
   2:  20  20  10

# free -h          <-- System memory increased
                total        used        free      shared  buff/cache 
available
Mem:           3.4Gi       504Mi       2.8Gi       1.1Mi       338Mi 
   2.9Gi
Swap:          1.9Gi          0B       1.9Gi

# numactl --membind=2 ls
Segmentation fault (core dumped)

# dmesg
[  310.119439] show_signal_msg: 20 callbacks suppressed
[  310.119499] ls[1153]: segfault at 1c454 ip 00007fb4cf771523 sp 
00007fff57753fe0 error 4 in ld-linux-x86-64.so.2[7fb4cf753000+27000] 
likely on CPU 2 (core 0, socket 2)
[  310.350803] Code: 01 42 08 48 8b bd 98 fd ff ff 48 8b 57 70 48 85 d2 
74 04 48 01 42 08 48 8b bd 98 fd ff ff 48 8b 97 60 01 00 00 48 85 d2 74 
04 <48> 01 42 08 48 8b bd 98 fd ff ff 48 8b 8f f8 00 00 00 48 85 c9 74
