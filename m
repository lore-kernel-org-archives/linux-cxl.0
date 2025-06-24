Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84423C51F
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794434; cv=none; b=kC1O22ogIndUqtzq7BkgYXJCj3PWT8cUjzreZaqLmiqv4aJpobdEcGTrEtzqK7mSBQoro9mwJ0H6NGx0BKtNG/C5iOg2M3MUWuoFT/YPPqJApoBmcCMiIEGOLDN9147vMVs2wcIb8vJ8hptEHHLLn+gioXcc96u9t2dv0JBrZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794434; c=relaxed/simple;
	bh=hd8yM7gZe71wuVSGRm0HZsLsBmUKwtnIQe072g9Fl5Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH9bK6BCjhBQMPE4pD0zyS5K0LlXp+8ZjLfXYJQWGjFqagwHgJEk3CzLATXYzHDbw4TOGzZDdY7gio1PPr1DaQOv3BP4vzhmpHCpn6gU1izYRi9EUcBtXZZLCh3E15u1pzyjU4/bM/CpbZKNPahMaaMdqkkK84t4IipWCRtEHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpBd2U4d; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpBd2U4d"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so956783a91.1
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750794431; x=1751399231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw2zabTft8ytTA3fL3MTQkbMY1IDA9wKLtkhoptW+GQ=;
        b=EpBd2U4dLMwK3cyEgoX+3qIm4q1bX0/pyk5RYJuweN8ys1n61g6gOQXoHHfQYkfpVx
         iOIf0Uk75/9XGmaX/5NvnMnwCQ+blZLRmdAvvoYd4lZB9l9PPsdz2beQx6wbVFZcywIu
         d/W335Wo6HgLDxGmnHC54ToqdQuE4/6cvUc5ohOuEi++/XZgWaw2KhS6SicXUrTij4HP
         3Yow+H8tEpz51tBEKUsKlsj4cWPxsSIqEqdU+lA1qY6L9f3b77PpXCZnQxnQH9IrKsty
         pzJv1zrSFcGCM3fVBg/GTrDCTU7rGoN8orFncZiPcEz62Zw0FHd/gBkryF43B40Vyfcu
         Ny8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794431; x=1751399231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw2zabTft8ytTA3fL3MTQkbMY1IDA9wKLtkhoptW+GQ=;
        b=GrreydpTILb7N2TqSsXRmT3QohB6NH/jc+Mi4+kK2dOITkAxTUGNd8sXdR9f8HM3eD
         KNYWOxxb3TGFAA3ArNxcHhcahURNQUOl8+Wo68fauKyTz7mukhKi/sz1E7kCZvwQpy1T
         Csvwn9r9LE+L6exQ7DqRELwr1kVODo9QZw78Eh6313gDFXbn7O+rEWI1/2+v6VU7hy1j
         qhmLqDYxnnu69Yl/2pA7sYkZdD18bI4okigyS+9KVQm5ghIlWmVrWgIydQjfB3lxNoK/
         MeyAEezgiPZs8IYL0ByXdZmBlomiy3bzuBccLpK3zhrKzudDZ1u4mLnPWZCW80rG0ntj
         TYLw==
X-Forwarded-Encrypted: i=1; AJvYcCXqrK2kZR9xmSI2bp1XHgfd7hdMji4SDlxqvvQwopAkNmV93G5gjnesVvAXzr25AkbrHXP1bNlOF6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmRBRZ27A5JxZ7HZpCLWvK1LcRh2TlogHthrUnP/D5bsnNeYU
	hf+L7eZ1I4xZ/aw3P13m8Ql7IM/2b7caX46X9crvPINdL8Ky6pW2DWij
X-Gm-Gg: ASbGnctjOqfPT23uaJlrzdQEoG661ANqOyxBaNPXjaINmFy6XWBhrgYaIaw7Yts8xPf
	WnCO/OCgKLIeuGg/1ylP62qrznebwdusMfy8d2SehSp434+K8BJV+tqN93opo3yZziy8kkuchF4
	DZSx1oC+nueqQ5vmK69tQaMgAkGDBZTErAQVebHL9JtaWkYTU4/6gXdOM/8I7ZXl6RMXezeZDJu
	9viIVGEyvHbeEMx8cLAC0fCSgz1eIEJ207m80ycTMKvE/x4a1KN7c/3HGw1FQPLLoQvSKsUt84O
	hEElyRSTi3W/dMbgvW+zQQFrxsfGbLlid725r/wUwHwy6fu1grTYF6oJ2PoMCcCqmw8rm6vbxuF
	T12A/Fm6UG6Nf
X-Google-Smtp-Source: AGHT+IF7lYDRhARnDMYq24nnc73O+0EocNdrE7faxKdesAbTGA4vUFqH6FYOc4ysMz9ocH9337WTmA==
X-Received: by 2002:a17:90b:1b06:b0:313:d6ce:6c6e with SMTP id 98e67ed59e1d1-315f25e394dmr187770a91.8.1750794431475;
        Tue, 24 Jun 2025 12:47:11 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a318733sm13598691a91.38.2025.06.24.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:47:11 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 24 Jun 2025 19:47:09 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, cminyard@mvista.com,
	Fan Ni <fan.ni@samsung.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, mst@redhat.com, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH qemu 0/5] hw/cxl/mctp/i2c/usb: MCTP for OoB control
 of CXL devices.
Message-ID: <aFsAvZqMCocyUcQ9@deb-101020-bm01.eng.stellus.in>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>

On Mon, Jun 09, 2025 at 05:33:28PM +0100, Jonathan Cameron wrote:
> This posting is primarily about sharing the USB device emulation to get some
> early feedback.
> 
> RFC reasons:
> - Known 'inaccuracies' in emulation (not obeying MTU in the to host direction for
>   example)./
> - Not sure what to do wrt to Klaus' I2C MCTP support given that has been stalled
>   for some time. For now only the headers are really shared between the
>   two implementations.
> - This is more of an FYI / request for testing than a formal suggestion that this
>   might be ready for upstream.
> 
> Why add a CXL FM-API over MCTP over USB device?
> - Can be emulated on pretty much any host system as USB is discoverable and
>   expandable. If you want a giggle, see the hacks on i386/pc and arm/virt on
>   we've been using until now given only I2C controller that works is the aspeed
>   one. e.g. https://gitlab.com/jic23/qemu/-/commit/134c2e3952b
> - Being able to talk to both the fabric management out of band interfaces
>   and the in band devices on the same host makes testing much simpler.
> 
> Background:
> 
> Back in 2022 I posted some support for controlling the CXL fabric via the
> spec defined out of band interfaces (CXL Fabric Management API - FM-API)
> over MCTP on I2C
> 
> https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
> I reworked that on top of the NVME-MI work from Klauss.
> 
> To that end I hacked the aspeed-i2c controller onto both i386/pc and arm/virt
> and posted kernel patches to enabled ACPI support for that device (more or less).
> It worked and has been useful in the meantime, but adding that i2c controller
> to those boards was obviously not going to be upstreamable - and to build
> reliable tests against it I don't want to carry this out of tree for ever.
> I messed around with a PCI hosted aspeed controller and might come back to
> that at some point.
> 
> In the meantime, DMTF published a transport binding for MCTP over USB
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
> 
> Kernel support duly followed early this year: drivers/net/mctp/mctp-usb.c
> https://codeconstruct.com.au/docs/mctp-over-usb/
> 
> Given the ease of adding a suitable USB controller on a PCI bus, emulating a
> suitable endpoint provides what I think is an upstreamable solution.
> 
> To use this:
>  -device usb-ehci,id=ehci
>  -device usb-cxl-mctp,bus=ehci.0,id=fred,target=us0
> 
> where target is either a CXL switch upstream port, or a type 3 device.
> 
> Then install the mctp userspace tools in your guest and configure it with
> 
>   mctp addr add 8 dev mctpusb0
>   mctp link set mctpusb0 net 11
>   mctp link set mctpusb0 up
> 
>   systemctl start mctpd.service
>   busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb0 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0
> 
> I've been testing the CXL commands with
> 
> https://gitlab.com/jic23/cxl-fmapi-tests
> (mostly because I still had them in my image from the i2c work)
> but libcxlmi is probably a better bet
> 
I tested this patchset using libcxlmi with the following configuration:
- kernel version: https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-04-13
- QEMU: upstream ToT with MCTP USB CXL and FMAPI DCD support:
  - MCTP USB CXL (https://lore.kernel.org/linux-cxl/20250609163334.922346-1-Jonathan.Cameron@huawei.com/T/#m21b9e0dfc689cb1890bb4d961710c23379e04902)
	- note: I modified the condition on line hw/usb/dev-mctp.c:509 to allow
	  the FMAPI DCD Management command set (0x56) to be processed
  - FMAPI DCD Management patches (https://lore.kernel.org/linux-cxl/20250605234227.970187-1-anisa.su887@gmail.com/)

- Topology (1 DCD attached to downstream port of CXL Switch)
	'-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
     -device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=2,sn=99 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=us0 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb1,target=cxl-dcd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k'

After creating the VM with the above topology, to configure the 2 MCTP EPs
(mctpusb0 and mctpusb1):

	mctp link set mctpusb0 up
	mctp addr add 50 dev mctpusb0
	mctp link set mctpusb0 net 11

	mctp link set mctpusb1 up
	mctp addr add 51 dev mctpusb1
	mctp link set mctpusb0 net 12

	systemctl stop mctpd.service
	systemctl start mctpd.service
	busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb0 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0
	busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb1 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0


To test this patchset, I used this program from libcxlmi:
https://github.com/computexpresslink/libcxlmi/blob/main/examples/cxl-mctp.c

To summarize, this program scans the D-bus for MCTP endpoints or takes the NID:EID
of the endpoint you want to open as arguments, then sends a variety of commands
(identify, supported logs, etc.) through the endpoint(s) and prints the results,
which I verified. Both methods of opening endpoints are successful and shows
the expected output.

To ensure this works end-to-end with an FM workflow I also tested with
this program, which allows users to interactively send the FMAPI Add/Release
commands from the command line:
https://github.com/computexpresslink/libcxlmi/blob/main/examples/fmapi-mctp.c

First I created a DC Region using this ndctl command:
cxl create-region -m mem0 -d decoder0.0 -s 1G -t dynamic_ram_a

Then I ran the program to add an extent of 512MB and was able to successfully
create a DAX Device using the following commands:

daxctl create-device -r region0
daxctl reconfigure-device dax0.1 -m system-ram

The output of 'lsmem' shows 512M added:
RANGE                                  SIZE  STATE REMOVABLE   BLOCK
0x0000000000000000-0x000000007fffffff    2G online       yes    0-15
0x0000000100000000-0x000000027fffffff    6G online       yes   32-79
0x0000001290000000-0x00000012afffffff  512M online       yes 594-597

> https://github.com/computexpresslink/libcxlmi
> 
> I'll post a tree with this on at gitlab.com/jic23/qemu shortly
> (cxl-<latest date>).
> 
> Jonathan Cameron (3):
>   hw/cxl/i2c_mctp_cxl: Initial device emulation
>   docs: cxl: Add example commandline for MCTP CXL CCIs
>   usb/mctp/cxl: CXL FMAPI interface via MCTP over usb.
> 
> Klaus Jensen (2):
>   hw/i2c: add smbus pec utility function
>   hw/i2c: add mctp core
> 
>  MAINTAINERS                               |   7 +
>  docs/system/devices/cxl.rst               |  27 +
>  include/hw/cxl/cxl_device.h               |   8 +
>  include/hw/i2c/mctp.h                     | 125 +++++
>  include/hw/i2c/smbus_master.h             |   2 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
>  include/hw/usb.h                          |   1 +
>  include/net/mctp.h                        | 100 ++++
>  hw/cxl/cxl-mailbox-utils.c                |  49 ++
>  hw/cxl/i2c_mctp_cxl.c                     | 289 ++++++++++
>  hw/i2c/mctp.c                             | 414 ++++++++++++++
>  hw/i2c/smbus_master.c                     |  26 +
>  hw/usb/dev-mctp.c                         | 639 ++++++++++++++++++++++
>  hw/arm/Kconfig                            |   1 +
>  hw/cxl/Kconfig                            |   4 +
>  hw/cxl/meson.build                        |   4 +
>  hw/i2c/Kconfig                            |   4 +
>  hw/i2c/meson.build                        |   1 +
>  hw/i2c/trace-events                       |  14 +
>  hw/usb/Kconfig                            |   5 +
>  hw/usb/meson.build                        |   1 +
>  21 files changed, 1722 insertions(+)
>  create mode 100644 include/hw/i2c/mctp.h
>  create mode 100644 include/net/mctp.h
>  create mode 100644 hw/cxl/i2c_mctp_cxl.c
>  create mode 100644 hw/i2c/mctp.c
>  create mode 100644 hw/usb/dev-mctp.c
> 
> -- 
> 2.48.1
> 
