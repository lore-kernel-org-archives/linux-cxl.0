Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE761549A
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T4KZ61Q1qz6K5qB;
	Wed,  3 Jan 2024 01:28:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 33AF91400DA;
	Wed,  3 Jan 2024 01:29:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jan
 2024 17:29:37 +0000
Date: Tue, 2 Jan 2024 17:29:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <qemu-devel@nongnu.org>
Subject: Re: Some thoughts and questions about CXL & MCE
Message-ID: <20240102172935.000004f7@Huawei.com>
In-Reply-To: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
References: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 23 Dec 2023 00:33:43 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> Hi guys,
> 
> I have some thoughts and questions about CXL & MCE mechanism.

+CC qemu-devel as quite bit of this is QEMU related .

> 
> CXL type-3 devices can be used as volatile or persistent memory, so a 
> poisoned page on them should also trigger a memory failure, to let OS 
> handle process using the page and let device driver recover the page.  I 
> am now investigating this.
> 
> Currently, CXL RAS is under development.  We can now inject POISON on a 
> CXL device by qemu (qmp commands), and then `cxl list -L` could show 
> those poisoned areas.  But the POISON injection is silent, I think we 
> need a singal here to notify OS to handle those poisoned areas when 
> injecting. 

Agreed. The emulation is far from complete.  It should kick off
the relevant event log entry additions as well under at least some
circumstances (depends whether we think we are injecting poison to be
discovered later - which it won't be because we don't check for poison
when doing reads and writes - I've not yet figured out how to do that
in QEMU). If we are using the inject poison opcode from the host OS
then we are missing the bit in 8.2.9.9.4.2 (CXL r3.1)
"In addition , the device shall add an appropriate poison creation
event to it's internal informational event log, update the event
status register and if configured, interrupt the host".
So that should do a General Media Event of type 04h - host inject poison.

For the qmp interface we should add control of whether we are injecting
poison that is intended to trigger an error now (e.g. what would result
from a scrub detecting it) or poison for detection later - either by
triggering a media scan, or by a host read / write.

If it's a scrub poison detection that we are emulating then we
should issue an uncorrectable GMR Event record with Memory Event Type
of Scrub media or maybe a 00h (Media ECC error) if we think some
other reason might cause it and transaction type 05 Media patrol scrub.

Note IIRC you can manually inject these records which will result in
appropriate events being reported in Linux they just aren't currently
hooked up to the QEMU poison injection (qmp or host interface).

If you have time to look at filling these more complex flows in that
would be great as it would make the qemu side of things easier to use.

> According to CXL 3.0 spec Figure 12-5, there are 2 methods 
> to send the signal: FW-First and OS-First.
> My understanding about them is:
> - FW-First method:
>    a. CXL device report POISON to Firmware
>    b. GHES calls CXL driver handler[1], which will handle the POISON

I'm in two minds about how to emulate the firmware first paths.
In the short term I'll get some old code I have running again that
lets us do general CPER record injection. However, we might want to
actually push the record creation into EDK2.  Meh - lets do it in
qemu first and see how bad it looks.

>    c. CXL driver handler translates DPA to HPA, construct a mce 
> instance, then call mce_log() to queue this MCE (? not sure)

Yes, the last step is missing currently I think? (I'm loosing track
of some of the ras flows).

> - OS-First method:
>    a. CXL device report POISON to OS by MSI
>    b. CXL driver will handle the POISON
>    c. same with the c. above
> 
> So, I think:
> Firstly, and obviously, we need to add a signal when injecting POISON in 
> qemu.  For example, call `cxl_event_insert()` after injection.
Yes - create the appropriate records and add them.  However we'll need
to enable adding different causes of poison so we know whether to do this
or to rely on later queries or not.

> 
> Secondly, implement a method in CXL driver to turn POISON to MCE and 
> push it into the mce_evt_pool for decode chain to process, then 
> mce_uc_nb on this chain will finally call memory_failure().
> 
> And a question:
> How to configure the CXL device to choose FW-First or OS-First singal 
> methods (methods for qemu and bare matel if possible)?

There is an _OSC for this.  We can hook that up in QEMU but it may be
controversial to do it there rather than in EDK2.

> 
> 
> I don't fully understand the CXL spec yet (it's difficult for me), so 
> the above ideas may be immature, but I really want to figure out how we 
> can make CXL & MCE work.  I'd really appreciate it if you could help me 
> on this!
> 
> [1] 
> https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com/T/#u

Great if you can look at filling in the details in this area.
There are still quite a few flows we haven't fully realized in emulation
or in the kernel.

Jonathan

> 
> 
> --
> Thanks,
> Ruan

