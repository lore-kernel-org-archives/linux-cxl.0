Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0164698
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B07194
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 05:40:20 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3f2uz9CNlgvIBBg--.47561S2;
	Mon, 09 Oct 2023 20:40:19 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnrlyx9CNlOH0AAA--.857S3;
	Mon, 09 Oct 2023 20:40:18 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	dimitrios.palyvos@zptcorp.com
Cc: linux-cxl@vger.kernel.org
Subject: Questions about the memory of CXL Type3 device offline
Date: Mon,  9 Oct 2023 20:39:47 +0800
Message-Id: <20231009123947.951689-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBnrlyx9CNlOH0AAA--.857S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAHAWUi-yYFtAAIsg
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFyUAF18AF15Cry5Kr4rXwb_yoW5Cr4Upa
	42yr18KFWrJF1UWw10vFWrGFyjqrsakay8XrWUJr4UAr1rGF1Utr4Fyryakas7trZYg3ZF
	q3WkJwsYqw1Ut3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, everyone!

I have used Qemu to do some CXL tests and I failed with configuring
a CXL region and numa node. 

My qemu command line:
qemu-system-x86_64 \
-M q35,nvdimm=on,cxl=on \
-m 4G \
-smp 4 \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-object memory-backend-ram,size=256M,id=cxl-mem1 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,addr=04 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-device cxl-type3,bus=root_port13,volatile-memdev=cxl-mem1,id=cxl-mem1 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
-hda ./disk/ubuntu_x86_test_dup.qcow2 \
-nographic 

Qemu version: 8.1.50, commit-9ef497755afc252fb8e060c9ea6b0987abfd20b6
Kernel version: 6.5.0
ndctl version: 77

My steps in the Linux system:
1) root@mali:/home/mali# ./cxl list
[
  {
    "memdev":"mem0",
    "ram_size":268435456,
    "serial":0,
    "host":"0000:0d:00.0"
  }
]

2) root@mali:/home/mali# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1
node 0 size: 1921 MB
node 0 free: 1705 MB
node 1 cpus: 2 3
node 1 size: 2014 MB
node 1 free: 1834 MB
node distances:
node   0   1 
  0:  10  20 
  1:  20  10 

3) root@mali:/home/mali# ./cxl create-region -d decoder0.0 -t ram
{
  "region":"region0",
  "resource":"0x190000000",
  "size":"256.00 MiB (268.44 MB)",
  "type":"ram",
  "interleave_ways":1,
  "interleave_granularity":256,
  "decode_state":"commit",
  "mappings":[
    {
      "position":0,
      "memdev":"mem0",
      "decoder":"decoder2.0"
    }
  ]
}
cxl region: cmd_create_region: created 1 region
[  126.862782] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
[  126.916152] Fallback order for Node 2: 2 0 1 
[  126.916699] Built 2 zonelists, mobility grouping on.  Total pages: 982290
[  126.916877] Policy zone: Normal

The results:
root@mali:/home/mali# numactl -H
available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: 1950 MB
node 0 free: 1785 MB
node 1 cpus: 2 3
node 1 size: 1985 MB
node 1 free: 1790 MB
node 2 cpus:
node 2 size: 0 MB
node 2 free: 0 MB
node distances:
node   0   1   2 
  0:  10  20  20 
  1:  20  10  20 
  2:  20  20  10 

root@mali:/home/mali# lsmem --output-all
RANGE                                  SIZE   STATE REMOVABLE BLOCK NODE          ZONES
0x0000000000000000-0x0000000007ffffff  128M  online       yes     0    0           None
0x0000000008000000-0x000000007fffffff  1.9G  online       yes  1-15    0          DMA32
0x0000000100000000-0x000000017fffffff    2G  online       yes 32-47    1         Normal
0x0000000190000000-0x000000019fffffff  256M offline           50-51    2 Normal/Movable

root@mali:/home/mali# cat /proc/iomem
190000000-28fffffff : CXL Window 0
  190000000-19fffffff : region0
    190000000-19fffffff : dax0.0
      190000000-19fffffff : System RAM (kmem)
2c0000000-abfffffff : PCI Bus 0000:00
fd00000000-ffffffffff : Reserved

Questions:
1)Why the meomory of CXL node is still offline?
2)Is my configuration process standard?
Hope I can get some helps here, any help will be greatly appreciated.

Many thanks
Yuquan

