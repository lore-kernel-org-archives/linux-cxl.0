Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0462C19B
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="144175390"
X-IronPort-AV: E=Sophos;i="6.04,297,1695654000"; 
   d="scan'208";a="144175390"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 01:33:48 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 17DCCD2A08
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 01:33:46 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C3BCBF4D1
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 01:33:45 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A61F4E5A1B
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 01:33:44 +0900 (JST)
Received: from [10.193.128.189] (unknown [10.193.128.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D489D1A0071;
	Sat, 23 Dec 2023 00:33:43 +0800 (CST)
Message-ID: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
Date: Sat, 23 Dec 2023 00:33:43 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-cxl@vger.kernel.org
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dave.jiang@intel.com,
 vishal.l.verma@intel.com
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Some thoughts and questions about CXL & MCE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28074.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28074.000
X-TMASE-Result: 10--8.125900-10.000000
X-TMASE-MatchedRID: 6Yvl3or3fgpQD3BO44j0URFbgtHjUWLyss3J45iL6l9i5ur6mjeG6Eop
	D+RCCRBkeaVc+Jw5xstZlEXb58TGrIxxTMlLewfdVnzlQiaE21qlLADMASK8x0tYyuL5Cqaxj8x
	Vj5MF/3qHrLqxWmCofb5Pgm2mJeUz0wEEuQfazOOdsAVC1/oGnCpykp1AmBYahWlVSEM0OnxCIy
	KeBKUqgr8z3N8IwH4UPMp4ulOr3sLlWiNI/3lAD461Z+HJnvsOrzl8sNiWClKbKItl61J/ycnjL
	TA/UDoAzmifKQLKn/t0HSe131POnuJGF26G8SWy8lP6F/raTZj6CxJ5baM0J2IPPWIu+7nS8jbR
	pfpcxOPssr/gmtuJxb623D8YVHRYNkUSDDq742k=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi guys,

I have some thoughts and questions about CXL & MCE mechanism.

CXL type-3 devices can be used as volatile or persistent memory, so a 
poisoned page on them should also trigger a memory failure, to let OS 
handle process using the page and let device driver recover the page.  I 
am now investigating this.

Currently, CXL RAS is under development.  We can now inject POISON on a 
CXL device by qemu (qmp commands), and then `cxl list -L` could show 
those poisoned areas.  But the POISON injection is silent, I think we 
need a singal here to notify OS to handle those poisoned areas when 
injecting.  According to CXL 3.0 spec Figure 12-5, there are 2 methods 
to send the signal: FW-First and OS-First.
My understanding about them is:
- FW-First method:
   a. CXL device report POISON to Firmware
   b. GHES calls CXL driver handler[1], which will handle the POISON
   c. CXL driver handler translates DPA to HPA, construct a mce 
instance, then call mce_log() to queue this MCE (? not sure)
- OS-First method:
   a. CXL device report POISON to OS by MSI
   b. CXL driver will handle the POISON
   c. same with the c. above

So, I think:
Firstly, and obviously, we need to add a signal when injecting POISON in 
qemu.  For example, call `cxl_event_insert()` after injection.

Secondly, implement a method in CXL driver to turn POISON to MCE and 
push it into the mce_evt_pool for decode chain to process, then 
mce_uc_nb on this chain will finally call memory_failure().

And a question:
How to configure the CXL device to choose FW-First or OS-First singal 
methods (methods for qemu and bare matel if possible)?


I don't fully understand the CXL spec yet (it's difficult for me), so 
the above ideas may be immature, but I really want to figure out how we 
can make CXL & MCE work.  I'd really appreciate it if you could help me 
on this!

[1] 
https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com/T/#u


--
Thanks,
Ruan
