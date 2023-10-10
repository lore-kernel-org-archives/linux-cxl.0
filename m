Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAB65C
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAD99181
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 23:47:29 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXcs9x8yRlvbIcBg--.38192S2;
	Tue, 10 Oct 2023 14:47:13 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBncMRr8yRlQFYAAA--.299S3;
	Tue, 10 Oct 2023 14:47:08 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: gregory.price@memverge.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dimitrios.palyvos@zptcorp.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: Questions about the memory of CXL Type3 device offline
Date: Tue, 10 Oct 2023 14:46:48 +0800
Message-Id: <20231010064648.1103157-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBncMRr8yRlQFYAAA--.299S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAHAWUi-yYFtAArsD
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWw1fGr13WrWrGF1fArW5KFg_yoW5Xw48pa
	1xtryjkr4xJrnrWa4kJFnxXryYvw1Fvan8GryDAr4Dur18try8Ar1xtas0kFWYvryfGr12
	qan5JF1vgw1kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-07 18:56,  gregory.price@memverge.com wrote:
> because you likely have auto-online of new memory blocks sets to false.
> 
> use `daxctl list` and  `daxctl online-memory [dax-device]` to online the memory

Thank you Gregory. It works! :)

BTW, I aslo did the same test in 'virt'(arm64) on Jonathan's development branch, 
however, it would automatically allcate CXL memory to numa node 0:

root@debian-bullseye-arm64:~# cxl create-region -d decoder0.0 -t ram
[   68.653873] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
[   68.660568] Unknown target node for memory at 0x10000000000, assuming node 0
{
  "region":"region0",
  "resource":"0x10000000000",
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

In addition, with 'daxclt online-memory' I can online the memory on node 0:
1)root@debian-bullseye-arm64:~# daxctl online-memory dax0.0
[  144.137685] Fallback order for Node 0: 0 1 
[  144.137819] Fallback order for Node 1: 1 0 
[  144.137872] Built 2 zonelists, mobility grouping on.  Total pages: 1011494
[  144.139050] Policy zone: Normal
onlined memory for 1 device

2)root@debian-bullseye-arm64:~# lsmem --output-all
RANGE                                  SIZE  STATE REMOVABLE     BLOCK NODE ZONES
0x0000000040000000-0x00000000bfffffff    2G online       yes      8-23    0 
0x00000000c0000000-0x000000013fffffff    2G online       yes     24-39    1 
0x0000010000000000-0x000001000fffffff  256M online       yes 8192-8193    0 

Memory block size:       128M
Total online memory:     4.3G
Total offline memory:      0B

With Jonathan's qemu branch(cxl-2023-09-26):https://gitlab.com/jic23/qemu.git
My qemu command line:
qemu-system-aarch64 \   
-M virt,gic-version=3,cxl=on \
-m 4G \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-3,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=4-7,memdev=mem1 \
-cpu cortex-a57 \
-bios QEMU_EFI.fd \
-smp 8 \
-device virtio-blk-pci,drive=hd,bus=pcie.0 \
-drive if=none,id=hd,file=./disk/full-rootfs-debian-bullseye-arm64.ext4 \
-nographic \
-object memory-backend-ram,size=256M,id=cxl-mem1 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-device cxl-type3,bus=root_port13,volatile-memdev=cxl-mem1,id=cxl-mem1 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \

Is there anything else I missed in this environment?
Maybe Jonathan has already helped someone else with a similar problem :)


Many thanks
Yuquan

