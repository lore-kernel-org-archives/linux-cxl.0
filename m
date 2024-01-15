Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873C160
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jan 2024 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="147741365"
X-IronPort-AV: E=Sophos;i="6.04,195,1695654000"; 
   d="scan'208";a="147741365"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 09:11:24 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3404BDC148
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jan 2024 09:11:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 279F5BF3C7
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jan 2024 09:11:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 96EDB20097E68
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jan 2024 09:11:19 +0900 (JST)
Received: from [10.167.214.93] (unknown [10.167.214.93])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E04E91A0072;
	Mon, 15 Jan 2024 08:11:18 +0800 (CST)
Message-ID: <dc9e1186-fc92-34b3-51fc-820b3b954eb4@fujitsu.com>
Date: Mon, 15 Jan 2024 08:11:18 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] daxctl: Remove unused memory_zone and mem_zone
To: Ira Weiny <ira.weiny@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "fan.ni@gmx.us" <fan.ni@gmx.us>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20230811011618.17290-1-yangx.jy@fujitsu.com>
 <TYCPR01MB10023F98F51B2AFE3E6B65A0E83CEA@TYCPR01MB10023.jpnprd01.prod.outlook.com>
 <65695d348908f_110db929496@iweiny-mobl.notmuch>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <65695d348908f_110db929496@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28120.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28120.003
X-TMASE-Result: 10--6.612500-10.000000
X-TMASE-MatchedRID: AzgLcq71PUyPvrMjLFD6eK5i3jK3KDOot3aeg7g/usAutoY2UtFqGAFV
	KntB9/BKQZFJJCZL/pe6TdtM+wDf5E/w47NVRfpUEhGH3CRdKUXnY0PxvS5OkJsoi2XrUn/JIq9
	5DjCZh0w+mmw2nKUUqO54vhk1EvsR2bNx1HEv7HAqtq5d3cxkNXtfLla9KfT6x3USwZkmO2ldcT
	Hp7qsTsenQLyPCRZosawwCAK+qxr7uHFzdvA94iwR7wsHG1mAjlfsH/YW7vQbQNp4jEVX6XeSlE
	bHP0Gc+hdiSWiIwR3Jef5IJPCWvcDLKiGdpyLj09wbuOM3EBb0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Hi All,

Kindly Ping.

Best Regards,
Xiao Yang

On 2023/12/1 12:12, Ira Weiny wrote:
> Xiao Yang (Fujitsu) wrote:
>> Ping. ^_^
>>
>> -----Original Message-----
>> From: Xiao Yang <yangx.jy@fujitsu.com>
>> Sent: 2023年8月11日 9:16
>> To: vishal.l.verma@intel.com; fan.ni@gmx.us; nvdimm@lists.linux.dev
>> Cc: linux-cxl@vger.kernel.org; Yang, Xiao/杨 晓 <yangx.jy@fujitsu.com>
>> Subject: [PATCH v2] daxctl: Remove unused memory_zone and mem_zone
>>
>> The enum memory_zone definition and mem_zone variable have never been used so remove them.
> 
> NIT: I don't know that they have never been used but they certainly seem
> to have been moved to the library.
> 
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
