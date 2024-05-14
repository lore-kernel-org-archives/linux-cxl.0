Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674517BB9
	for <linux-cxl@vger.kernel.org>; Tue, 14 May 2024 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674581; cv=fail; b=Q+Wr8iAEbO0wrDNG3vqecoXQ3kLWILptN1y05oz/8Zs5hmKgHPewb7AJ0UK8Afo6qCdYDGNKtzxX+zgQZdPWW6bWuCL5o+wnVnpVb7xMPG+7/zk1ysz3fZnxLlEFD97wULUzjBYc0AI4oZrQwHVUkP2BAghuGlBxj6UkX6Qd93k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674581; c=relaxed/simple;
	bh=fshuL3P81g10vla+D4N84HFPKgERREkklSC3kj7aoPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5u6tOEGtJlWFj8ThnNISfM2QTSGJmLZWcDFfKiFb+yaA0TZeGvTVSpVbtW5kOBeu2Gc6KHSe2fZld0szhL4N2poKGvFnxUoDo0/LpVmBgFoHhfisoXddiFhOvxHrv9OnIRVAvNGWZFYL6ZWhvSC2df34gK1SrBeHl6Gb5tqZ3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KgTWa+ws; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KgTWa+ws"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715674579; x=1747210579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fshuL3P81g10vla+D4N84HFPKgERREkklSC3kj7aoPg=;
  b=KgTWa+wsujexKBnWJDToJJ6Bxz3vjTJ+nWsYs4j6Avme2NXpgNwh669c
   4SFqtKdruCypl+QtakG67qiCiGuzx7EPCp/aeKh3CqM0F06h0YSJo0QiB
   pZMCJNWg0gweaq6qbVahQIOu/q13jP5h5b07oqjvx1gWl+TOQQ8hG1KKL
   16SszPfRSPii8ta/0LJbGS8q5npX33PHgAYF83dPpw40/8gM2QjiaueOZ
   9Ob/PxQF23BIlawNkoAFppCtPqtDgu03aFes533/wDq8jbrNLN7xYzAzv
   pwnuIM6v5+IYRqOW230H/OaZSgOI6e/xPmHTaYQdGSIgsF3cIK7NlooKJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="119477901"
X-IronPort-AV: E=Sophos;i="6.08,159,1712588400"; 
   d="scan'208";a="119477901"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 17:15:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH46JcrwHW5YMN8EMen0g3VV8ce4Eqgq5YNxuWCyNEeZStPAof/6LHjquQijg2O2TR6WUzdVjy3lqaLP0eyluKS0mHaggMhEW11rhRuDxNAr2fjdTp+dSN5w00TA+PP6DUhi3JT0/2ws2/hdvhR7cRFr04DtYqiOYphPErL1mmBYjCeAplsxIpvu8RRrdGFagbScgFWs15iQz04DrifvXxTn45DlHGSCWlacdXPHmMccN5GPN4CepjlB9uYqrvzhUM/JUotsorEZ7t6zAE9sdBWjjYnXUu4m8hItZNg1z73JgUwuY21sCZ/2Ctn5WoreDBBdYF1lRFg688iePCGMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fshuL3P81g10vla+D4N84HFPKgERREkklSC3kj7aoPg=;
 b=F56ecGeB0nY/tsZSYhCbMnMg396yDZnYKUPbYv/V5fRuLBvkFJIXsmJSeqeNbwi5MD4Dg6utG09XCDwlykHvkcv/lvTc8T3qBh6753yl7pURZJYYzV+eFhGwuw1pVL6pDJ0F3sTNfshb5BPxFhABIKrbik9u7MuD9CxO4VOyyuUs9ijFvHIZCSKIBxKjlu90YBMELQTDxvRXSdgGR122d7ms+N+Lwt18BLtKX9XtfxIcVvGQjGrAEqY76yylKRrmv1iiXIPWHFg3mQlX/enTlSNLYdUZynoqvIJyFe+h/bxgaOkmDt8kAr+GmT8XVgld6cg0SDbPx+sxB0lTd8GVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB6659.jpnprd01.prod.outlook.com (2603:1096:604:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:15:00 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:15:00 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>, "Jorgen.Hansen@wdc.com"
	<Jorgen.Hansen@wdc.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v7 04/12] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Topic: [PATCH v7 04/12] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Index: AQHakehklFIGGCr5o0uWInYu8dPRrbGWic0A
Date: Tue, 14 May 2024 08:14:59 +0000
Message-ID: <c91272cb-f42a-4ead-8d5c-e3ab0544d952@fujitsu.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-5-fan.ni@samsung.com>
In-Reply-To: <20240418232902.583744-5-fan.ni@samsung.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB6659:EE_
x-ms-office365-filtering-correlation-id: 892f67bf-c56f-4b81-899f-08dc73edf2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|376005|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXc0WUh4YlRIbnhjTmdISDhOcUlEbkN1K1JkNWxKZUhZaEhYOE1SbnFPcS92?=
 =?utf-8?B?eWFDcHpaV2hyU2wvTHlwY1V2cEJ1eVJsUDN4YVZ3dlRkN0s0bzVVc3R6N2FU?=
 =?utf-8?B?ck41cFdzdXU3SDh0Tk90Mm9iSTRrRVczV0JON3lCeXNPSk9vTnVCTGZIK2VN?=
 =?utf-8?B?QktyNU04SHdwbDFCR1lub0ZhR2E1aUtlZlF1REl6bkZEMGpKS1p6ckp0bTZl?=
 =?utf-8?B?Y2xwQ0lIaXYzZEg2TWFMTWZOdmxNaS9xd3RXTzNuSGFFZDhwUm5WeFNDeGkz?=
 =?utf-8?B?YnUwTityWmM1VVdSVW51SjJjSEIvOXhBT1IzYXk3ZWdWRmlKRTRUNnNzRnh2?=
 =?utf-8?B?Q1VpV2t5WjJsb0daTm1oaE9ZdFo4emlPa25vamQ2Y1BJcDhzV0xFTFVJaHBk?=
 =?utf-8?B?bTQwNjRmYnRQQjFyN0NXSEMwQjZrbDNpelpGSTRid0srN2p3RUJ2clZHdVls?=
 =?utf-8?B?VTVWUkpwOEZ6ZG1oQVo1RjJIOEJMeXR4Y2NyWFpNRllYaExTQlcyVUM5UVpZ?=
 =?utf-8?B?RFJ1QzkxODhCZlVndlJ0K2JZV2N6U25INWZWSG1FVnVDa3huYmtsZjF3QjFY?=
 =?utf-8?B?M3hqd0w4aWJxN0Zzc0hGZTRJM0FuYzZhTkcrMENSNjZZSFd2dnd5SVhSS2Mv?=
 =?utf-8?B?d3c2d2U5VCsrQm9kZjRLcDQzaEEzTnVGNVFDZE5jNkYwYVViRjV5Y3JNc2da?=
 =?utf-8?B?MDRJWlBzQjhaUngyMUJRVnRCMEF0U2ZZbjVXalRWalBlZHM1WXMwckdaUlBY?=
 =?utf-8?B?WEZ6K3kvMzgzOEpyQ01pajdiWEE2QlhlTnh1ZDdYemJzcTYwamk1YmN0TlIz?=
 =?utf-8?B?MFJoOGs0WklnNEc2dzJqY3dlSFcxdjRTR1BydHJWSFpRY1dLdW5FZVliQzY0?=
 =?utf-8?B?WjJaMjlvSnlneVdIQW5EL1F3cnhyZzhNMEZLOWgzYVdsbjV2SUg4NjE4Uk9N?=
 =?utf-8?B?Rk8xOUxWVGw0TWlEeGlHKy82NDdGcVl4TzlsL00reHREV2xSWG1OUDVvVi9Q?=
 =?utf-8?B?bnprcE9vRU9hWFBHZ1BNS21uSWlzRVpuaGoyRjNhVEtYcThpY083ZnlUd2lQ?=
 =?utf-8?B?aUFMY1FjZzhOcHlyU0VWRGNMamVkSy9NMW8rcTZsZnEyd1VZWkU0NmVHZnQ1?=
 =?utf-8?B?TGJUMkQvZGVXSzdGRUlwWU9IbHhHY2lJT29TeUpuTzNlZWlVYW1paXg0YzUv?=
 =?utf-8?B?RGh0bmhUbysydm5rWFJ0Z1Fzemk5bEpsQTh2T3JCMVMvNTdGU2Y4NXRYM2w0?=
 =?utf-8?B?MytGUEJ2MXM3MVVzVU5ReXE3cFNIV0Zuai9qRnRhVmtXU1hDWUtPcmZwNFFk?=
 =?utf-8?B?NEVmcDVQWVJNYkNaT2hSN3pXMmlwWEQyNnc2ak45R2NEMmUxUUFhQTY4eXdS?=
 =?utf-8?B?N3VPR1VqZHhscjhmdWM3SmptUzlRTXpKbTZzWlJIR2NCNVp2Wm1kYXZnMkc2?=
 =?utf-8?B?cVFKakdSeVMrODhPaFh1WG1Pa3JIRWp6SU1BN2ZBYUkvcGVzcG4xNWNkbmV4?=
 =?utf-8?B?NU5UVmtBSXYrSnhQbHJYbDMyQnE1akxpUVRHTzhjajRMSnVpSnBIUHJaOW5T?=
 =?utf-8?B?OUhZalUrR0NvWVh5YXV5VmVueEhiUUpJT1VHZEZQSHZ2czZzSFZ3RnpOeCsv?=
 =?utf-8?B?NDN6THZjQ0ZFNG0xR2R6SXplQ09RL3BaTHFOWmhoeVRDaDM1OVBPbUE1RWRx?=
 =?utf-8?B?RDBXNXdFU0VCUVdhQVlrU0E5Mk1UZkpQUEMxQllOSVpudWY5Nm1RMlpCNnRG?=
 =?utf-8?B?aC9KL25nUEVjSjhhcW13Y0FNRHRVcFlZdnRjRG02WTcrNVh2UTJTbGI1Z2Vr?=
 =?utf-8?Q?kbz6X1k2001mvOWJw8pOUdW+8eAsg2F8WUPmM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHZVZmpyVkY2bkVsS0o2MWF4bURyVDUvUm9yd2pHUGxTUFZURDNMUjV5UVhP?=
 =?utf-8?B?alpoNHllVFlkNUdFbm9rN2ErbGpIN3htOHVDUDB4eXlxRnA2ZGVrcTdsbnJx?=
 =?utf-8?B?STZKVllxSTFreTNrTDRlVytaRnpsazVsS0M3WDNaVDJ6K3EwSlFnVytuS0VT?=
 =?utf-8?B?YmlJT3k0S21kMHU2V2VNNnFsaEJZd3Z3VmdaZVN0dHVLRFgrMkJSQkd3ckdv?=
 =?utf-8?B?WXR3Qnk1eitYTEEwdnJkU1d5dXJiaVV5Y1N6cldnK05mcEEyZCtNd21OTVVJ?=
 =?utf-8?B?NDFnMk0vcWlSd2o0Wkp3dUFLaVlpVENyZ1Z3N0xWZjJBRnFmTWpJdmQxOXY2?=
 =?utf-8?B?QU0yVFNacE1FS013ZlhtMHR1RDZZdHduaG51SXB6dGJDOUFkYjJNZ2NGNWRI?=
 =?utf-8?B?R2FycGtURmRXN0lqU0I0N05pTWpDN2wrSWlveUl6NUVKNlFkUGxaY1hyYnB5?=
 =?utf-8?B?TzMwRkhBV2hOWlFSUS9ySmwwTWx1aUdKYlVhNkN6eW5mWVluelFPczAwazFH?=
 =?utf-8?B?enAxQ2VIVXVEejhPSCtSN3kwV3hNOENpaEF0bzlmWGlXd2RZV0hzbXJGa01m?=
 =?utf-8?B?amF2NnZHQllPeU4rUVZIN0NsQzlsRmFOc1hqOWhTQ1Z3UFIvR0J5eDZxai8y?=
 =?utf-8?B?NFBDeUsydUE2OXBIdlNTNExtMlJ2MUJuNytaZndKM1B5RysyajFjQWQzVlZC?=
 =?utf-8?B?Tm5ZMWZaZEV0MzhqcFFEMFVJTWdWYVJhVHBtRlkreGlxSmswQllsa29DRVRx?=
 =?utf-8?B?a3NIOGkxYXg1enhTN0ZwQjlid2JmbFBhcEhJK0RuOWdCbS83b2hBc1JaeEl2?=
 =?utf-8?B?WTFsMWdYcTkyMWhEN1dZRkJ4eGVzTm9vcUZ4ZlRzalF1bnQxSkphRVhjdzRa?=
 =?utf-8?B?TnBuYlpMcWg4b052aG1lcGI1MmdUdVFoN2VTbkJQZTdnV2ZQckRxeEdIeHlV?=
 =?utf-8?B?bXlVenRDOUlyNXJYMHFFcWVSdDI3M0U3UjExKzVjc0VaMDc5U2U1MEp4Qmox?=
 =?utf-8?B?aTA3YXVLUlFNdzB5TCtMeGpsZGtuaksrWmdHc0tXcXRoTVhWWUtla2pRU0E2?=
 =?utf-8?B?TXlKMEpjSFF5KzdCb3kzSy9YTVVmRmFpclNhWEdUUHB1djVvNUoyRmtEdW5r?=
 =?utf-8?B?LzF2RWlTdDZLU3Z6WUZIUzU4TjZhT244eDdlWUdVaWhVSVJDaThhQWJPVkQ0?=
 =?utf-8?B?OHBubER4WEVjcFc0dTJ0eXQ5TkpMTmNLb0gyakFONUZhOHJDbklVNzAvUDVi?=
 =?utf-8?B?a0Q0WUMzQ2JQVlYya1Q5WlZjMWhLOW1XY2JFbFVwOE8wSzQ1emhWWmNZMEZm?=
 =?utf-8?B?czZRdWhMSHVuM3oyaHpoNDdjc1J4dlVIYmFQZlZ4Z0tRVjVUd2gvMGZOMmtW?=
 =?utf-8?B?VTk4K3E0Zm1OWDdQanVKcGZmZ21tQlJmaGsxMnJnanF5c2F5RWJTR0dSc25Q?=
 =?utf-8?B?dlNpV1Q0TTVSY3BUNlhVQWlhWWI3K0U2T3BGTlA4Mm1YRkVTYlk2Tkl0NWwy?=
 =?utf-8?B?S04xc1QvalZFM1pDMitGRTBnQlF2Nm04d1hHYmhNVDBnakxBOE92bUxHckF6?=
 =?utf-8?B?MXkzRGVxWmlMelVSeXNDOHUvTGQ0MVBMQzRwN1VRbDg1U0pFUFhQWGQ5a3F6?=
 =?utf-8?B?d295T3plbUZQQXNGa001Q3MwSXBGNDZyMVRlUkgweXkxd0tLSW9Zd2NXcUZz?=
 =?utf-8?B?cTFTZlp5dFFTL05mNXBacFg4RUpSKytXWkpvb1R2eDVmRUR5YmVzZFA4aTEw?=
 =?utf-8?B?M3NtdFlid1o0d2hCZDAvdE5sMFNLczhGV1lIQmJrYkVoOVptZjh1RVhTWkR1?=
 =?utf-8?B?cGhacmxaOFlzL09ISGZQeDN2TXFNYnBNZVFOcWRtQVdPRUpwOVNJUTlhcWRD?=
 =?utf-8?B?WHdiN3dVOXYrclkrQWV4ZzQxWmg2NXFKcW9veWZaZng0VUxiTTZWVkE4R0xW?=
 =?utf-8?B?TThGMjY0VGFkeHZCNEJXdGRhbjE5cEUyWW54Rkt5ODZiMEZqZGdQci9iZkJX?=
 =?utf-8?B?TmdpY2Urdmo1N1RvM3RXa3FXWjd3ZTZUQlVZanBhcy9FcU5ZM3ZUdFFibzFH?=
 =?utf-8?B?eVAza1h6OW5UclhLUW9mRWdnUDk1MDZhZjdWNjJhT3dQN0YrVDZFbzk0N21j?=
 =?utf-8?B?dnp4Q2Nnem42Sm9uY1dYNno2MWVlMmRXSTJTVTNVazNQTGg0ZmJIZlF1NVVK?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC33F5B8F272DB41BDD19B18F04B6995@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oi55RYNgDkKjVEbqr9y6huktXPQjoQAseOrzZDP+yGTNc6Zn+4u2Or9Cki+uPnDJ4kQiBUO258pmHYQJzTKVAl9AonOoBAOmDTHAk408a6kwetnLkoz35J9HqNeaxrBk2d7cDWhUS/ms0nhC3BL2A9g7/bRKurdqIXgzYZepsdDXFzxkKSU8gxo3+P7b/tyRDfkn/zcc7WwQkT/zMneJ3xFvcRelIujQHwZCfZdWGATwDTRTaWgTt0mC89XkcCM9KZcshiQ+J940ueovbv1YcUYcUzoAdXMhZ12jccok2fhrhpR2JKE/OvBq00M9iIACS1FA4Tq53aJfnPi3sTYXYG62Q53Y/UfPiVOPdrg3N6YovdVKftOXaJ0dh6SHv/UH8Z5ddMR+9f5l9P+zthNi61iv38lAvOV102tpX46B7iD30GZlmU5pAzI7gtAJTE8Blw+TkB3ESX4654ehcrMOy/MkKgQIsZP3TG8fZipeFkH0wI1wLOM2GmYhk6+8hhPjjWYI9l7L1/Q4BSQGFCcdk71uzureUtGG6KtZGOFus4MCEsZPcXNIUhoaZeSpAy1WpPJaqPy/bcYbLsncTb/q/jS09iTmIs6d31URaUoP2Z2zz3E2SBIbomhbWzgOrL5z
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892f67bf-c56f-4b81-899f-08dc73edf2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:14:59.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qeq56jZgw+LZX192HWNQKMxpXyELAGgt8fz2jyWg/Rlnd0FkZkyYT4Rxx4sWDnUVwdpdQPT2qbrJaawkbNarwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6659

DQoNCk9uIDE5LzA0LzIwMjQgMDc6MTAsIG5pZmFuLmN4bEBnbWFpbC5jb20gd3JvdGU6DQo+IEZy
b206IEZhbiBOaSA8ZmFuLm5pQHNhbXN1bmcuY29tPg0KPiANCg0KPiArfQ0KPiArDQo+ICAgc3Rh
dGljIGJvb2wgY3hsX3NldHVwX21lbW9yeShDWExUeXBlM0RldiAqY3QzZCwgRXJyb3IgKiplcnJw
KQ0KPiAgIHsNCj4gICAgICAgRGV2aWNlU3RhdGUgKmRzID0gREVWSUNFKGN0M2QpOw0KPiBAQCAt
NjM1LDYgKzY3NiwxMyBAQCBzdGF0aWMgYm9vbCBjeGxfc2V0dXBfbWVtb3J5KENYTFR5cGUzRGV2
ICpjdDNkLCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICBnX2ZyZWUocF9uYW1lKTsNCj4gICAg
ICAgfQ0KPiAgIA0KPiArICAgIGlmIChjdDNkLT5kYy5udW1fcmVnaW9ucyA+IDApIHsNCj4gKyAg
ICAgICAgaWYgKCFjeGxfY3JlYXRlX2RjX3JlZ2lvbnMoY3QzZCwgZXJycCkpIHsNCj4gKyAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgInNldHVwIERDIHJlZ2lvbnMgZmFpbGVkIik7DQoNClRo
aXMgZXJyb3Jfc2V0KCkgd291bGQgY2F1c2UgYW4gYXNzZXJ0aW9uIGlmIHRoZSBlcnJwIHdhcyBh
c3NpZ25lZCBpbnNpZGUgY3hsX2NyZWF0ZV9kY19yZWdpb25zKCk7DQpUcnkgZXJyb3JfYXBwZW5k
X2hpbnQoKSBpbnN0ZWFkDQoNCiMzICAweDAwMDA3ZjFmZGM0ZmFmYzYgaW4gYW5ub2Jpbl9hc3Nl
cnQuY19lbmQgKCkgYXQgL2xpYjY0L2xpYmMuc28uNg0KIzQgIDB4MDAwMDU1NWZkM2VkYmVhOCBp
biBlcnJvcl9zZXR2DQogICAgIChlcnJwPTB4N2ZmZTZkMWEzZGUwLCBzcmM9MHg1NTVmZDNmZTI2
MmIgIi4uL2h3L21lbS9jeGxfdHlwZTMuYyIsIGxpbmU9ODA3LCBmdW5jPTB4NTU1ZmQzZmUyZmUw
IDxfX2Z1bmNfXy4yMT4gImN4bF9zZXR1cF9tZW1vcnkiLCBlcnJfY2xhc3M9RVJST1JfQ0xBU1Nf
R0VORVJJQ19FUlJPUiwgZm10PTB4NTU1ZmQzZmUyOTM5ICJzZXR1cCBEQyByZWdpb25zIGZhaWxl
ZCIsIGFwPTB4N2ZmZTZkMWEzDQpjMDAsIHN1ZmZpeD0weDApIGF0IC4uL3V0aWwvZXJyb3IuYzo2
OA0KIzUgIDB4MDAwMDU1NWZkM2VkYzEyNiBpbiBlcnJvcl9zZXRnX2ludGVybmFsDQogICAgIChl
cnJwPTB4N2ZmZTZkMWEzZGUwLCBzcmM9MHg1NTVmZDNmZTI2MmIgIi4uL2h3L21lbS9jeGxfdHlw
ZTMuYyIsIGxpbmU9ODA3LCBmdW5jPTB4NTU1ZmQzZmUyZmUwIDxfX2Z1bmNfXy4yMT4gImN4bF9z
ZXR1cF9tZW1vcnkiLCBmbXQ9MHg1NTVmZDNmZTI5MzkgInNldHVwIERDIHJlZ2lvbnMgZmFpbGVk
IikgYXQgLi4vdXRpbC9lcnJvci5jOjEwNQ0KIzYgIDB4MDAwMDU1NWZkMzgxOWM5ZiBpbiBjeGxf
c2V0dXBfbWVtb3J5IChjdDNkPTB4NTU1ZmQ4YjJmM2UwLCBlcnJwPTB4N2ZmZTZkMWEzZGUwKSBh
dCAuLi9ody9tZW0vY3hsX3R5cGUzLmM6ODA3DQojNyAgMHgwMDAwNTU1ZmQzODE5ZDdiIGluIGN0
M19yZWFsaXplIChwY2lfZGV2PTB4NTU1ZmQ4YjJmM2UwLCBlcnJwPTB4N2ZmZTZkMWEzZGUwKSBh
dCAuLi9ody9tZW0vY3hsX3R5cGUzLmM6ODMzDQojOCAgMHgwMDAwNTU1ZmQzOGI1NzVmIGluIHBj
aV9xZGV2X3JlYWxpemUgKHFkZXY9MHg1NTVmZDhiMmYzZTAsIGVycnA9MHg3ZmZlNmQxYTNlNjAp
IGF0IC4uL2h3L3BjaS9wY2kuYzoyMDkzDQojOSAgMHgwMDAwNTU1ZmQzY2NjYTliIGluIGRldmlj
ZV9zZXRfcmVhbGl6ZWQgKG9iaj0weDU1NWZkOGIyZjNlMCwgdmFsdWU9dHJ1ZSwgZXJycD0weDdm
ZmU2ZDFhNDBkMCkNCg==
