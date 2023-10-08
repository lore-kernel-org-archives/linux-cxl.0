Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6E3205
	for <linux-cxl@vger.kernel.org>; Sun,  8 Oct 2023 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AB539D
	for <linux-cxl@vger.kernel.org>; Sat,  7 Oct 2023 23:51:22 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnrWFXUSJlHurgBQ--.20392S2;
	Sun, 08 Oct 2023 14:51:03 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAXnANSUSJlQFAAAA--.436S3;
	Sun, 08 Oct 2023 14:51:00 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: A confusion about cxl.mem in CXL drivers
Date: Sun,  8 Oct 2023 14:50:36 +0800
Message-Id: <20231008065036.468324-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAXnANSUSJlQFAAAA--.436S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWUgXCYL6wAIsS
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtr4ftryUtw48Cr17ZrW5Wrg_yoWkCwcE9a
	ykG3W7tw4DGrZrt3ZIgFsFgFWj9ay2yr1rJw48Ga13G34fAF95GFWvqFySyw4DKa1Ik3W5
	Ar13Jw4Iy3W3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry for resending this mail as I still confused about it.

On 2023-09-20 20:19,  jonathan.cameron wrote:

Thanks for your patient explanation.

>
> So from driver side of things, the CXL.IO stuff is either in ECAM (for config
> space) or mapped as PCIe BARs.  The CXL.mem stuff is mapped via the Host Physical
> Addresses described in a CXL Fixed Memory Window.
> 
> So the right type of access is used based on the underlying hardware performing
> the routing for the appropriate Host Physical Address range.  Same applies
> on top of QEMU.
> 

Therefore, from the view of kernel side, the kernel do not need to distinguish the physical cxl subprotocol
(cxl.io,cxl.cache,cxl.mem). In fact, the underlying hardware would directly finish this work so system software
don't care about it.

According to the instance of qemu virt machine, my understanding is below:
1) CXL.IO: finding, setting and enumerating CXL ECAM/BARs (programmed in cxl_acpi, cxl_pci drivers)
    Underlying hardware performing the routing : PCIe RC
    
2) CXL.MEM: host is going to access the memory mapped in CFMWs 
    Underlying hardware performing the routing : HDM decoders

Many thanks
Yuquan

