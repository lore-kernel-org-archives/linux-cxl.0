Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F28F40
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099440; cv=none; b=tfi9Xt/GhPNhUJa+9mINxBxUKVdcVPvSSqDfqFQSkSdXNYLe38D+hgPc4an/SKvHfyWPeNI87J3Tud6n5lD/Kl70dNK3XsPQWyeucNMrsiqzaaw0bYd8lh0Zpu42h5JUMlGigIt3sehcJKLMBkWGiHh75mbluwbvVpeEjZnjROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099440; c=relaxed/simple;
	bh=72UkhnPL+g0Uyg2NEZmBSrze6Hmf/CcLcnABje0NleI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Lz901Hnu2Hz/LKC9LFZIndFKYiWe84WF+j1CWBjjiklgZ3oSh2UHyHFVCAw6l15yuqwB66HzryPIEkMx9f63hf04jEsA5orpmEYB0Kli9N/VxQkjNjwl8LYW0kui6gmkBjq+LcTXT4xGjZNAFbP+vLIJd7w7bxMTBJpkDq5ABiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=twRVrrh8; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="twRVrrh8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707099437; x=1738635437;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=72UkhnPL+g0Uyg2NEZmBSrze6Hmf/CcLcnABje0NleI=;
  b=twRVrrh8DPFAUqdKrEtXAzIbPQzPhBiGupDc/oBEYSdDnDRrd2QC8Voc
   23pUPKet1oMZNR0FaBzbE1v32duODYvw6jjO8B3o8C6oKZGe5/qOtpUHN
   idP4gW+pX7TsNpt14uWqqqCxnZBQdceHCSE3Y0tyrUVOmzwYfO1m/ZxFf
   eShj6Cvxn19PR9HDJCeL+mONdAckTPlzpf7ZXfSYPKIb3U3UsM1Wx+Pkp
   qKtPZQD9paO16TzVKU7WqaLxOY84Nm8MAqFtKAen6jVKMEF7ztaGiCPWP
   Ilt2bYbxIsQBgorxpUfcNorZ3ENIylgDfaoskicJjA5Mx2Xs1m3xEy170
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="127765188"
X-IronPort-AV: E=Sophos;i="6.05,242,1701097200"; 
   d="scan'208";a="127765188"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:17:14 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F28AD3EAC
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 11:17:11 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D0943D3F04
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 11:17:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 59DF220095255
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 11:17:10 +0900 (JST)
Received: from [10.167.220.145] (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C9B5B1A009A;
	Mon,  5 Feb 2024 10:17:09 +0800 (CST)
Message-ID: <96ff7ec5-de8f-ca65-00e0-7bc609707042@fujitsu.com>
Date: Mon, 5 Feb 2024 10:17:09 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>
Subject: Question about region creation failure issue
To: dan.j.williams@intel.com, dave.jiang@intel.com, vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28168.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28168.004
X-TMASE-Result: 10--11.846300-10.000000
X-TMASE-MatchedRID: T3hsd5K8wICGYAKJjm5IPSkMR2LAnMRpw+MUH8mZTtQkt9BigJAcVpGh
	HyDD4zfOo/aGRMOiEMZK0wo9SRyQTb9jX++auvv+rMZ+BqQt2NpNLPQl0QAltIRZzsPO1L+tSfS
	+N55v9tmUAC//TDpk6kMEJ9maChY/wwX0o7eolMDfSQNpZkETVCmVdGjEbh6ToQT3OGQazZFTac
	dDUa7rn1pzy7jeSDXSnagtny7ZPcRNfs8n85Te8oMbH85DUZXy2KDPNsqphTL6C0ePs7A07cjHc
	hynrO5b0AW2/cId/SYI3NhWe6EeCQA6f0YwPs7t7EkM1C63sFY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi Dan:
I used 'cxl' command to create a region but it failed, the topology is 
that: 1HB+2SWITCH and each swtich contains 8 memdev.
The root cause is that the positon of mem15 (pos is 2) is lower than the 
distance (distance is 8),
and I found that the distance feature is discussed in the patch 
https://lore.kernel.org/all/166752185440.947915.6617495912508299445.stgit@dwillia2-xfh.jf.intel.com/
but I don't know why it is.
Does the distance feature refer to some sections of Compute Express link 
specification or anything else?
Please help to answer this question.

The operations detail are below:
# cxl list -M -P -D -T -E -u
[
   {
     "ports":[
       {
         "port":"port1",
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
         "ports:port1":[
           {
             "port":"port7",
             "host":"0000:17:00.0",
             "parent_dport":"0000:0c:01.0",
             "depth":2,
             "nr_dports":8,
             "dports":[
               {
                 "dport":"0000:18:03.0",
                 "id":"0xb"
               },
               {
                 "dport":"0000:18:01.0",
                 "id":"0x9"
               },
               {
                 "dport":"0000:18:05.0",
                 "id":"0xd"
               },
               {
                 "dport":"0000:18:07.0",
                 "id":"0xf"
               },
               {
                 "dport":"0000:18:02.0",
                 "id":"0xa"
               },
               {
                 "dport":"0000:18:00.0",
                 "id":"0x8"
               },
               {
                 "dport":"0000:18:04.0",
                 "id":"0xc"
               },
               {
                 "dport":"0000:18:06.0",
                 "id":"0xe"
               }
             ],
             "endpoints:port7":[
               {
                 "endpoint":"endpoint17",
                 "host":"mem14",
                 "parent_dport":"0000:18:00.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem14",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:19:00.0"
                 }
               },
               {
                 "endpoint":"endpoint9",
                 "host":"mem5",
                 "parent_dport":"0000:18:03.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem5",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:1c:00.0"
                 }
               },
               {
                 "endpoint":"endpoint10",
                 "host":"mem6",
                 "parent_dport":"0000:18:04.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem6",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:1d:00.0"
                 }
               },
               {
                 "endpoint":"endpoint12",
                 "host":"mem8",
                 "parent_dport":"0000:18:07.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem8",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:20:00.0"
                 }
               },
               {
                 "endpoint":"endpoint18",
                 "host":"mem12",
                 "parent_dport":"0000:18:06.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem12",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:1f:00.0"
                 }
               },
               {
                 "endpoint":"endpoint8",
                 "host":"mem4",
                 "parent_dport":"0000:18:01.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem4",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:1a:00.0"
                 }
               },
               {
                 "endpoint":"endpoint11",
                 "host":"mem7",
                 "parent_dport":"0000:18:02.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem7",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:1b:00.0"
                 }
               },
               {
                 "endpoint":"endpoint13",
                 "host":"mem9",
                 "parent_dport":"0000:18:05.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem9",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:1e:00.0"
                 }
               }
             ]
           },
           {
             "port":"port2",
             "host":"0000:0d:00.0",
             "parent_dport":"0000:0c:00.0",
             "depth":2,
             "nr_dports":8,
             "dports":[
               {
                 "dport":"0000:0e:07.0",
                 "id":"0x7"
               },
               {
                 "dport":"0000:0e:00.0",
                 "id":"0"
               },
               {
                 "dport":"0000:0e:02.0",
                 "id":"0x2"
               },
               {
                 "dport":"0000:0e:04.0",
                 "id":"0x4"
               },
               {
                 "dport":"0000:0e:06.0",
                 "id":"0x6"
               },
               {
                 "dport":"0000:0e:01.0",
                 "id":"0x1"
               },
               {
                 "dport":"0000:0e:03.0",
                 "id":"0x3"
               },
               {
                 "dport":"0000:0e:05.0",
                 "id":"0x5"
               }
             ],
             "endpoints:port2":[
               {
                 "endpoint":"endpoint5",
                 "host":"mem2",
                 "parent_dport":"0000:0e:06.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem2",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:15:00.0"
                 }
               },
               {
                 "endpoint":"endpoint19",
                 "host":"mem15",
                 "parent_dport":"0000:0e:04.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem15",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:13:00.0"
                 }
               },
               {
                 "endpoint":"endpoint14",
                 "host":"mem11",
                 "parent_dport":"0000:0e:00.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem11",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:0f:00.0"
                 }
               },
               {
                 "endpoint":"endpoint4",
                 "host":"mem1",
                 "parent_dport":"0000:0e:05.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem1",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:14:00.0"
                 }
               },
               {
                 "endpoint":"endpoint16",
                 "host":"mem13",
                 "parent_dport":"0000:0e:02.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem13",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:11:00.0"
                 }
               },
               {
                 "endpoint":"endpoint6",
                 "host":"mem3",
                 "parent_dport":"0000:0e:07.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem3",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:16:00.0"
                 }
               },
               {
                 "endpoint":"endpoint3",
                 "host":"mem0",
                 "parent_dport":"0000:0e:01.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem0",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:10:00.0"
                 }
               },
               {
                 "endpoint":"endpoint15",
                 "host":"mem10",
                 "parent_dport":"0000:0e:03.0",
                 "depth":3,
                 "memdev":{
                   "memdev":"mem10",
                   "ram_size":"256.00 MiB (268.44 MB)",
                   "serial":"0",
                   "host":"0000:12:00.0"
                 }
               }
             ]
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
         "interleave_ways":1,
         "max_available_extent":"4.00 GiB (4.29 GB)",
         "pmem_capable":true,
         "volatile_capable":true,
         "accelmem_capable":true,
         "nr_targets":1,
         "targets":[
           {
             "target":"pci0000:0c",
             "alias":"ACPI0016:00",
             "position":0,
             "id":"0xc"
           }
         ]
       }
     ]
   }
]

# cxl create-region -t ram -d decoder0.0 -m mem2 mem14 mem15 mem5 mem11 
mem6 mem1 mem8 mem12 mem13 mem3 mem4 mem0 mem7 mem10 mem9
cxl region: create_region: region0: failed to set target2 to mem15
cxl region: cmd_create_region: created 0 regions



