Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416928E2E
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912283
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 08:17:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8LLd21SDz6K94r;
	Mon, 16 Oct 2023 23:16:57 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 16:17:25 +0100
Date: Mon, 16 Oct 2023 16:17:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] CXL: Standalone switch CCI driver
Message-ID: <20231016161724.0000250b@huawei.com>
In-Reply-To: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
References: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 16 Oct 2023 13:53:19 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

FYI: Userspace tooling and something resembling documentation / test instructions at:
https://gitlab.com/jic23/cxl-fmapi-test

The tool covers the switch CCI and MCTP used to access individual components, plus
tunneling through them.

The code (in particularly the 'elegantly formatted output' and 'intuitive user interface'
clearly indicates why I should never be let near any userspace tooling ;)

J
> Note that the PCI SIG has recently release the MMPT specification which is
> similar to the CXL mailboxes. I would suggest that we don't get too
> distracted by that, but keep in mind that we may end up factoring some
> aspects of this code out into the PCI core and just use them here (at some
> future date!)
> 
> https://members.pcisig.com/wg/PCI-SIG/document/20109?uploaded=1
> 
> Based on v6.6-rc6
> 
> Chances since rfc4. 
> - Mostly a rebase because of fixes around sanitize handling.
> - Dropped new command support. For, now RAW all the way.
> - Aim is to support getting the QEMU emulation upstream.
> 
> I'll be posting user space code to test this against the QEMU emulation shortly.
> I just need to finish writing the documentation as getting it up and running
> is less trivial than I'd like (lots of moving parts).
> (I need this series on the list so I can point to it ;)
> 
> Introduction:
> 
> CXL r3.0 introduced the option for a PCI function, intended to sit on an
> upstream port of a CXL switch.  This function provides a mailbox interface
> similar to that seen on CXL type 3 devices. However, the command set is
> mostly different and intended for Fabric management. Note however that as
> we add support for multi headed devices (MHDs) a subset of commands will
> be available on selected MHD type 3 mailboxes. (tunnelling for DCD commands
> for example)
> 
> See: CXL rev 3.0
> 7.2.9 Switch Mailbox CCI
> 8.1.13 Switch Mailbox CCI Configuration Space Layout
> 8.2.8.6 Switch Mailbox CCI capability 
> 
> It is probably relatively unusual that a typical host of CXL devices will
> have access to the one of these devices, in many cases they will be on a
> port connected to a BMC or similar. There are a few use cases where the
> host might be in charge of the configuration.
> 
> These are very convenient for testing in conjunction with the QEMU
> emulation. CXL switch and type 3 emulation is in QEMU is not complex
> enough to make these particular interesting but that should change soon.
> 
> For now don't provide any additional commands over those defined for the
> main CXL mailbox and in practice that means the RAW command path under
> CONFIG_CXL_MEM_RAW_COMMANDS is used with the IOCTL to interact with this
> device and the fabric beyond it.
> 
> The foot guns are behind the same "don't enable this unless you know what
> you are doing" barrier as they are for type 3 devices. Note that the blast
> radius is far worse than for a CXL type 3 mailbox. This device can be used
> to rip memory out from under _other live hosts_.
> 
> Jonathan Cameron (4):
>   cxl: mbox: Preparatory move of functions to core/mbox.c and cxlmbox.h
>   cxl: mbox: Factor out the mbox specific data for reuse in switch cci
>   PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to pci_ids.h
>   cxl/pci: Add support for stand alone CXL Switch mailbox CCI
> 
>  drivers/cxl/Kconfig          |  14 ++
>  drivers/cxl/Makefile         |   2 +
>  drivers/cxl/core/Makefile    |   1 +
>  drivers/cxl/core/core.h      |  12 +-
>  drivers/cxl/core/mbox.c      | 453 +++++++++++++++++++++++++++--------
>  drivers/cxl/core/memdev.c    |  44 ++--
>  drivers/cxl/core/regs.c      |  35 ++-
>  drivers/cxl/core/switchdev.c | 129 ++++++++++
>  drivers/cxl/cxl.h            |   4 +-
>  drivers/cxl/cxlmbox.h        | 201 ++++++++++++++++
>  drivers/cxl/cxlmem.h         | 176 ++------------
>  drivers/cxl/pci.c            | 442 ++++++++++------------------------
>  drivers/cxl/pmem.c           |   6 +-
>  drivers/cxl/security.c       |  13 +-
>  drivers/cxl/switch.h         |  19 ++
>  drivers/cxl/switchdev.c      | 169 +++++++++++++
>  include/linux/pci_ids.h      |   1 +
>  17 files changed, 1123 insertions(+), 598 deletions(-)
>  create mode 100644 drivers/cxl/core/switchdev.c
>  create mode 100644 drivers/cxl/cxlmbox.h
>  create mode 100644 drivers/cxl/switch.h
>  create mode 100644 drivers/cxl/switchdev.c
> 

