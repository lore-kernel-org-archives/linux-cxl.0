Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50D221728
	for <linux-cxl@vger.kernel.org>; Fri, 16 May 2025 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374306; cv=fail; b=CRkbeJwx/hrRgujPfdRcclJdBmqv1RNQ20P46Mdtaru+1EN+J7nRQKnRXFWNxPnz3hfZA5Z5CYeoOC3mx/5nAxJ8tdXQNsjlNqta7hF0TznVt/JwttjevV2DBxHljqLmrlGvXVdcx5gyaW7eBof4NGEPiBScBTcGBvD1YUvZliQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374306; c=relaxed/simple;
	bh=NHmtG/q/wxDSxQXfea3H41/ABJwydvo52zHZMK+cofI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o7GDnk3eM+tmEiydlBEAvzJsGMKILeuOS10rRcU+3qURRXFwNAz1A0THHyvCyWf+FBiiYwPEzDClbsmwOlimOsFfI2GkREraJEv0pr1DHWvOywLzsBvo51jBiRNEvA0wA9U/KeDLQdG8pIOgOR1j057q/vZGZ3vxHLlzr3FEAuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sfap2s7S; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sfap2s7S"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1747374304; x=1778910304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NHmtG/q/wxDSxQXfea3H41/ABJwydvo52zHZMK+cofI=;
  b=sfap2s7SqNO+V9CweXqBrJi3AHCXZDBLtU3g1r9J8AYuv9wvxvSxn+PL
   q/jAF2WwtlYide5KuXsfetEASAWClNkst0i0yv5fy987XMLbVrU5TaTDD
   ZVyYOo8XuKPLQOOKqvzaMFmUr0KclGlYBfmIuFd2MzmyLgFIpXlnCXuIR
   qsm9cCurtbt9pHRHIa6qcx2DCNTQNlD9So7ac2a1EdLgDh+E/m7XAbyfL
   yj80MxfXWp3T6eRF+IkUTvTNTA57GBLEDJL/NddH4q5Hs94PFxOdzj96c
   nuSk57bxwQnAw8McW+rLpvuQXA1pBxHj/fq0+vTnm+jxDPma8O2nGS0Oh
   g==;
X-CSE-ConnectionGUID: n5hQl0a4SMuEn4oE4SJkGA==
X-CSE-MsgGUID: zWvbeVqMTY+v+vg1T7zExg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="162364865"
X-IronPort-AV: E=Sophos;i="6.15,293,1739804400"; 
   d="scan'208";a="162364865"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:44:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UckocF+WcDv3DdEU9gyAAb0CfRJd81zUBVOnwUMSrjhQqV4wEA0WDkO32cLD6eTP4ir0BEUUOh/JGswECO37qi1lcj/vKO1z72SDK5jdkrR68TFSeMKWeHZ4zei27Hl+BkQPpufwjKxrwk5bspLOQeXwVPx2JzJ979ooh6l5ODCzpAqvKiTRajFdeoe+IzW8XXHw9zpzXAyFB+/CEtgXknPZx9GVRleclNYgwP1msA8CiOFtH5wt3u0RI4Y4xHXGz19bW8/ogg0XA6THnGhQ2Zmc6FajhxPcCljAZHw3q4pf3hhsjMhksBa1ez4d5J6N+hcMHtKuyXHeGTNpl3Z0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHmtG/q/wxDSxQXfea3H41/ABJwydvo52zHZMK+cofI=;
 b=aIpaOTqZ6lqGFLdWU9ymvFVvj5Rb+d6eCITyizboKuS1M2WaozuigwqHg3J+h56MtuCbgMYKUEi5O+Ib0fO8bpsh1ZI+3YN6/ZSrh+4+2A8H6W5kKK3N3B0tqfiHk8OQb5nYJJZIK/m9kgGUE/rML4ommfmAPVHYcZcQ+JuQxVfuZLgsZTv/jOBsuV/2Q6gZ37zHyakkjKdaYyl3k32QpQeg59468WDJ+YBA7HMONFHJ+YFa4va6vcpKsvmbQmkxgWzfz4Wkav2SLmntGmroQLUawPKgJAvw538P75pNhcNTHBCde68lqBpfeFFKCcXjDm6uRaGrUyAGc5IU3p/+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com (2603:1096:603:8::10)
 by TYCPR01MB7124.jpnprd01.prod.outlook.com (2603:1096:400:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:44:52 +0000
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4]) by OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 05:44:51 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru
 Kitayama <itaru.kitayama@linux.dev>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH v13 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Thread-Topic: [PATCH v13 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Thread-Index: AQHbw/h4PckKTVX9hEm4X5q3HyMek7PUw1eA
Date: Fri, 16 May 2025 05:44:51 +0000
Message-ID: <7647626c-8409-4c92-b000-06d5475aeebf@fujitsu.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB1557:EE_|TYCPR01MB7124:EE_
x-ms-office365-filtering-correlation-id: a35845b1-beaa-4e1b-cf46-08dd943cc74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFpNRG84cUlQMHU3aElWWkxPem9ZY2E5MlIxVXNVQmJBRkhyNmJQUHdtWnk2?=
 =?utf-8?B?YUtsL3JYQzZxNlh6c3ZSWjNoN1VzNHN3VjQzZ3NweFZ0SjNVOFR6ejFRL1FS?=
 =?utf-8?B?d2E4MVF3aVRNcUUxczVqWG5qSDNBeGhMUmJERFFRQXdMMXY3Mm44dmh4V2R1?=
 =?utf-8?B?RUtWMXRUaFpvOFpDUlpaWEJ0WUhHcENRZjd5cmNaS09uK2pRNzFwYmhQMlZZ?=
 =?utf-8?B?NVZQMkE0WVVQRkthWXdBV3hCMzI5aVJRNUZWdThzMlFBSVQvWnd0RGkzWDV4?=
 =?utf-8?B?T1ROTmplRVdlbGRXTHl0c05pUVZnNTc4MHlsRFdhNkU1VHJ0VUtNdjV6clIv?=
 =?utf-8?B?amJLZ1pQcjBzVEN2UXFPKzFqdTJ5c01tYWhHSjJNdm52czdwRFoxQzJSS1l4?=
 =?utf-8?B?a1VqTHRzVXN0YnhzUVpxMWphN0JqaFJoMGJpYXl4T01tQ1o1eTBRaHVzYmto?=
 =?utf-8?B?VkQ5akY4MzRNZGRuVXErdURqbnFpVU1SUExuQTJRemFZWFp3QkN5emlRWk03?=
 =?utf-8?B?d2RzNnlNMCt3YkgzTXZSUGxocXVBZlorRnVXdTU0bGYrbU5taW1kZ25BeVVC?=
 =?utf-8?B?MHBTaFJQWGoxdUFrM2NPdXJhU0tjZTMxS2JBSVRBbWVxT293RXRTSXRvWGRS?=
 =?utf-8?B?RFgvdi9XMVdnM3M2ckJCdGwwVndxckRzMHk0Yk16b3o2dVhidmJVOUtJbDFM?=
 =?utf-8?B?Zk5BeG9VQmVFWjhFRXZpZDBDZVVKRXBGNGtnaTlxblg3dERtV09IL1ZIcnVr?=
 =?utf-8?B?R0hUVjZJWGVIN29RdzFVSXIrcU5ZR3poQWxWYlRYU3YxVjV2L3NLeVNJN1Jv?=
 =?utf-8?B?RnZwaGZGUFA0TDc4RnJaZGs1MlIvdjVQWGkxYXc2NllVODRhRGZySnlIZ0w5?=
 =?utf-8?B?cW45RGdGcXBiNE1WYThvOFIyZ0VCcnRJdXIrZEFSUWFtTXd4MVJTbkJidmFH?=
 =?utf-8?B?V1d2WGlVQUJQZmtnRzlrN2htY0tsMVBBQ3IxTVo3OEZ2d3I2TjJkTWtrZnpR?=
 =?utf-8?B?bmNabEVnZWJhdTZtRStpNjN2RjUrdWtHMnB6WUM0RkhXeE9mK0N6Q3B2UTVy?=
 =?utf-8?B?bnUzdGhxS0d4RVFHZXp4NXdCWHhpOFhoZ2pxRkJROHMybC9tbWVwZThjaTdk?=
 =?utf-8?B?SkV5MGdITHJYOHI4WC9EbGlkQ0RxYTFUSGVJU2xpMUg4bkZkVGg1Ny81dnZo?=
 =?utf-8?B?UnBKM2tRakYxYXZlM2svRDMwdEZ0cWUrSWhrY1hkcTNsUlBzai90WE84aCtJ?=
 =?utf-8?B?K2Z0OWxZd0NWek9VcHFEcHU4djBjV0NLQlBwQVoyYlUvdy9oZllaVm11UTdU?=
 =?utf-8?B?QjZNc09CbnZBaVdFci9GTzJkZXRpaXZXZGJJWDMzZWJ1dHhPemNLYkJLM2Vw?=
 =?utf-8?B?UzBVNkp3ZVlaSjFtemlPRTJ0OHFEa1lTVHgyZjhUU2gzeUJnRWF0SEkwQWp5?=
 =?utf-8?B?MG96aiswR044RFlFV0ZyTU5pWFJscHVNSEU5Y3lNRE1RbE5odTNLM2VYMFhl?=
 =?utf-8?B?Uk55RXBRM2JVZ3pMSDgzQVI0RFYyRHRScDRFNjF6NXhKOVBJKzFTK3dsUGlm?=
 =?utf-8?B?cTRrQlp3aE1UVzdrdFhEVDFSV1lLMzFnZ0pmNlpTM1drYk1VMEsrRE1rZmxz?=
 =?utf-8?B?NW5xSU1adzAyOGVxWStpcXluQ0xFL05wVEUrZ0w3Q1k2VkZLRlNMOFh2SzR3?=
 =?utf-8?B?VjZMWWpIZ3JEVlZQanB6L0FMN0gxYWdkOGM1YUx4cEwwYU9XUG5YU1ZLTjJx?=
 =?utf-8?B?SndxaFdNY3lHTHluZnNOdEsvWFpkbVBGVnFXdVpDVUtRTzVGUXF3aWVpTEgy?=
 =?utf-8?B?Smw4MU04aWZLaytPRVdrWFpaMFhZR2hkWU5NSEx2U3NPaFphY0RUQTlxM0tL?=
 =?utf-8?B?OVZYbWFvNVZxQXpsajU0WFRUZTdMTGlqMStMSXVGVlQxcFV4WllQR2FsMXI0?=
 =?utf-8?B?QjJHOGRVME13MGZhTjNIUFVySlk5WDhPTzNLTFJ6TmZ2UndmQlhIQUNaZFBw?=
 =?utf-8?B?N0JMYXRyVUd0bG1FRit2MDVsQUxqbGUzSzdiWjkzZzE2UUNaRzNVdS9KN1Ba?=
 =?utf-8?Q?dlvS/L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB1557.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVVZcXpYMUgvMzNoNFY5enBNSmpSZFg5YTdVZWFLNmpKYnVrc0hZdjJWK2J2?=
 =?utf-8?B?a3hLU1hPWWxZZmlJTzdxSXI3dzhVK1JmT2JSRjY3S3o1eWdZcEV2ZTN6cGMr?=
 =?utf-8?B?QllHTEJ2Y1MwV2k4KzM5dU9WTE8weVlSaHhFSExqV0ZoS3gvaUpud3d5dXlG?=
 =?utf-8?B?eG5Rd2lkVjFwQ3pxVGVHcDBnZ3pMV3FCNy95czV4QkZTQmUrVmdaK2QxT29C?=
 =?utf-8?B?RXVQMHp2RXpYeEZXS05QbTdSSzRQTHYwaWhRdmd4ODM3ZmQyQVRLZGRieWJu?=
 =?utf-8?B?UjRyY0NPZW82dmlPV1Z0N20xTDVMQmpERmtValhjaTRLM2dMK1FPMG8vcXFG?=
 =?utf-8?B?eCtnZ09KckVUR2NIdERLSnU0T1VnTENUdEg3aVhIVUJKbDdIaEp1MklGNmdO?=
 =?utf-8?B?K29YU2kvbXFYc1NyNkREcUlya3VhZHd2dFFXSWRBcGNOYkZPbVNUelRtQ29P?=
 =?utf-8?B?am53UHpBbCtpaUNKVnhzR2VCaDZTdVlwL2JjcmJGY1NtcHh0STVicEpoTENz?=
 =?utf-8?B?Mzd3bUxYbW9LSU1HZ3p6TnhpN0VwcUhQR29JM0s1OXNRRzJIWDVvWnhsVEcz?=
 =?utf-8?B?WjA0Yk9Kc1dHZXNjU3laQnBiU2NXYjVnMTdnc1BwTHNTVjN3REREdG5oWTV6?=
 =?utf-8?B?RmZCZTErbkFISTZKZjAwaDIvOUpQeGx3eHRnSVduYXVUY08yQ0FESTRvbmRV?=
 =?utf-8?B?ekl0MmkyeWRFVXNETCs1WGhCeUhkOEdBZnJkZlBwb2hkSzI0QktneDlyWml6?=
 =?utf-8?B?anAyU0pNbHBRUHpLa05XVllEOW94WmM0SzNabi92aEd1dFBsUENZanRLSjZU?=
 =?utf-8?B?aGdlYW1rR1h6Z2hTQTRtNEZTSEpwaW1oYlJQSDB4MkZqYitBUktyNVA2aG1j?=
 =?utf-8?B?OFc5TmpnYmdyUVZSU0MyR3FvZ0JYaXdpbWV6YzNIelJzenUwSDhWM2JEZ0oz?=
 =?utf-8?B?Q0NVOWdmWlNBRXorZWlmZ2J2ZFJOM0NsWkpBS01TdGtHb0xOcitPYnptM1dZ?=
 =?utf-8?B?a21aUjlqRFB5ZFZPem1rZmNHSENjMXhqTjYwZnFNaEhkZTZDcm1VQ1dCVG5r?=
 =?utf-8?B?WWVyRHNaL0M1aUNmYldpb285MnRYVFlSdTRENjdrVGdBU1plcUtzbStLZVRs?=
 =?utf-8?B?cVJaSjUzU2dIejdKZ0ljWFRjL0JuS0o1Y3hUVm5ZVVFPZ1NCZkk3cytYQU9u?=
 =?utf-8?B?Q1F6LzBrOS9HMWdNOFN6bW5hRXVZQmREWWhWT3ZHYSt1bHlLQlhwMGFpOGsz?=
 =?utf-8?B?dG5BT2RJenNzdHVHWndWRjFoY0xDaDFvNUV4NlhkZFQwVmdWWm9ZUENoOCt4?=
 =?utf-8?B?ZGlidCtxazJvb2M0b2pYYTYyNXl4emlicjdNODlDOWFQR3pwRVhrRjBRRElK?=
 =?utf-8?B?Q3k0aEVieWRycWxkNmxCdEhEL2lvQi82VzZER05RbkM2NE1yaEZNaFp5d0dI?=
 =?utf-8?B?Z2FHczdXY3JSRFZzUjBCaEdEc0l1QVFMRW9XVVJTbEhNTng2aDNPblliWXR3?=
 =?utf-8?B?Ync5blhabzUwYlE0RzNoRWpqejA2QWtWV0hCU0k0WFdlcW9OT3A2MVorV0dq?=
 =?utf-8?B?ZWUzWVN1TjFCUURrMWhVWFRwazRWd09ZVkFMU1l6ZE05OTJEVThhSktLeVJL?=
 =?utf-8?B?d3ZqaVdVa2RqeCtFV3JMVkN4TUF6TGpaODFYTnNreE9BNVdQMTUvTm1jSE96?=
 =?utf-8?B?NzlUT1lvSEYvVmJEY0VmL05oVVFlcktzV1ZpTG93dGhkZmZscGJNdGV5Tkg0?=
 =?utf-8?B?VStvMWozbC93bnF5T1ExdUtEMnVyTHJoNHNSQjAzV1lMK1JRNmZ2UmMyZit4?=
 =?utf-8?B?Ym04ekNNWnlzdy9Wb3RiVzZsSEdSbXNMUllrSm9DemtsMzc3V0RDcWFVUVlz?=
 =?utf-8?B?WW9JVFZYOGZuU2NYaEQ4K0RoRXQzRWg1N2RzZGdlZm5ZOUVtbitjM0JJMUlX?=
 =?utf-8?B?dndqUFpuKzJaN3psdGZxVERqS2cwb1ZJZ0hXZ0htYXBId2IwYjhnVVBQdmp4?=
 =?utf-8?B?YXpKbnBhdDhBNWp4Uk5ydE5HNFk1Vi9SMVJ3OG1xWWU0bEQ4eTgwc0wxeVZz?=
 =?utf-8?B?V0JOWUI4R1R6QVdPTkFPMW5SQUFGK1dPQXlMVy9Fano3K05OaUxPZUt4Qkkv?=
 =?utf-8?B?S1Byd2V3Nm9TUmVlKzZhSS9DREZnamt3LzJ3bHR2Y2Jpemg5akRTSS9pMHZP?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC7A2529633AA146A7F9979FAE002D4B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XifZtT0w3dz5ge/sbc0mQPR/hxz8JDYIr4s7YCXPfr7yzMSJ9G1+vMAYOaFSPIVLkwHcj58zAWLPGo0yT9JeDKWHTHBzwYoYKBjuEu2PbVAv/KwtxCqUerYQGi8zLHwV/d6Rhce4P7m/tPp/ffJdTcTS0BM/njXjO4AbyjEEYiy9Xl9BGCas/lPX2i3aooFtwohkPueDuoC1idqECWyBmXplJwcQIIL6S/i9WBuNbNZTJsMuE/cwHfY89lJk9sIqcGINdG5/f3zbEeRGzJz5vXsiGdednJgrNBzQtdxBTT1Eu6SCFlPMWIQv489onwgfQm3+rh+p1WVrRLr69tXPYGQJ90llePJmomjycEQ8l/DNkCQGgbVkyovv3cBz1LMHr2itUcYPl7GWO6YSpqshs+iFO5PC4IEy3VSzhpYWzHGW8YwLZKX4yWHBw0TQrNdezvzVhoR6n71fC+rWApp1EIoc+/bnk3dTCu/tpdgdfV4FdwwyVcUImtoCqRGV1kaYI8I1r7HvKqpJWBJuZBb3gPWkxQV/tmqji/VUsD+ozsO5t5numhG2I6mt2pGurZQG9f5xjRqwA73ECJoBNrR7JxF/3lP5FMNrd1nAewOh+tTR+zQOc4H84Oy1dDOIKJwq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1557.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35845b1-beaa-4e1b-cf46-08dd943cc74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 05:44:51.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TF4Jeht/7aKF4aCP/9I7yeNtTbVIzAqCiOeMVQeCuvf7q0Tw/RoFpWG4Ve4o6BwUggFJ4Zt76UNMVUmXHdcYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7124

DQoNCk9uIDEzLzA1LzIwMjUgMTk6MTQsIEpvbmF0aGFuIENhbWVyb24gdmlhIHdyb3RlOg0KPiBU
byBlbmFibGUgdGhlc2UgdG8gYmUgZm91bmQgaW4gYSBmaXhlZCBvcmRlciwgdGhhdCBvcmRlciBu
ZWVkcw0KPiB0byBiZSBrbm93bi4gIFRoaXMgd2lsbCBsYXRlciBiZSB1c2VkIHRvIHNvcnQgYSBs
aXN0IG9mIHRoZXNlDQo+IHN0cnVjdHVyZXMgdGhhdCBhZGRyZXNzIG1hcCBhbmQgQUNQSSB0YWJs
ZSBlbnRyaWVzIGFyZSBwcmVkaWN0YWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFu
IENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCg0KDQpSZXZpZXdlZC1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gLS0tDQo+ICAgaW5jbHVk
ZS9ody9jeGwvY3hsLmggfCAxICsNCj4gICBody9jeGwvY3hsLWhvc3QuYyAgICB8IDkgKysrKysr
LS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9jeGwvY3hsLmggYi9pbmNsdWRlL2h3L2N4
bC9jeGwuaA0KPiBpbmRleCA3NWU0N2I2ODY0Li5iMmJjY2U3ZWQ2IDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2h3L2N4bC9jeGwuaA0KPiArKysgYi9pbmNsdWRlL2h3L2N4bC9jeGwuaA0KPiBAQCAt
MjcsNiArMjcsNyBAQA0KPiAgIHR5cGVkZWYgc3RydWN0IFBYQkNYTERldiBQWEJDWExEZXY7DQo+
ICAgDQo+ICAgdHlwZWRlZiBzdHJ1Y3QgQ1hMRml4ZWRXaW5kb3cgew0KPiArICAgIGludCBpbmRl
eDsNCj4gICAgICAgdWludDY0X3Qgc2l6ZTsNCj4gICAgICAgY2hhciAqKnRhcmdldHM7DQo+ICAg
ICAgIFBYQkNYTERldiAqdGFyZ2V0X2hic1sxNl07DQo+IGRpZmYgLS1naXQgYS9ody9jeGwvY3hs
LWhvc3QuYyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+IGluZGV4IGUwMTAxNjMxNzQuLmI3YWE0Mjlk
ZGYgMTAwNjQ0DQo+IC0tLSBhL2h3L2N4bC9jeGwtaG9zdC5jDQo+ICsrKyBiL2h3L2N4bC9jeGwt
aG9zdC5jDQo+IEBAIC0yNCwxMyArMjQsMTUgQEANCj4gICANCj4gICBzdGF0aWMgdm9pZCBjeGxf
Zml4ZWRfbWVtb3J5X3dpbmRvd19jb25maWcoQ1hMU3RhdGUgKmN4bF9zdGF0ZSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1hMRml4ZWRNZW1vcnlXaW5k
b3dPcHRpb25zICpvYmplY3QsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCBpbmRleCwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gICAgICAgRVJS
UF9HVUFSRCgpOw0KPiAgICAgICBnX2F1dG9mcmVlIENYTEZpeGVkV2luZG93ICpmdyA9IGdfbWFs
bG9jMChzaXplb2YoKmZ3KSk7DQo+ICAgICAgIHN0ckxpc3QgKnRhcmdldDsNCj4gICAgICAgaW50
IGk7DQo+ICAgDQo+ICsgICAgZnctPmluZGV4ID0gaW5kZXg7DQo+ICsNCj4gICAgICAgZm9yICh0
YXJnZXQgPSBvYmplY3QtPnRhcmdldHM7IHRhcmdldDsgdGFyZ2V0ID0gdGFyZ2V0LT5uZXh0KSB7
DQo+ICAgICAgICAgICBmdy0+bnVtX3RhcmdldHMrKzsNCj4gICAgICAgfQ0KPiBAQCAtMzI1LDE0
ICszMjcsMTUgQEAgc3RhdGljIHZvaWQgbWFjaGluZV9zZXRfY2ZtdyhPYmplY3QgKm9iaiwgVmlz
aXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwNCj4gICAgICAgQ1hMU3RhdGUgKnN0YXRlID0gb3Bh
cXVlOw0KPiAgICAgICBDWExGaXhlZE1lbW9yeVdpbmRvd09wdGlvbnNMaXN0ICpjZm13X2xpc3Qg
PSBOVUxMOw0KPiAgICAgICBDWExGaXhlZE1lbW9yeVdpbmRvd09wdGlvbnNMaXN0ICppdDsNCj4g
KyAgICBpbnQgaW5kZXg7DQo+ICAgDQo+ICAgICAgIHZpc2l0X3R5cGVfQ1hMRml4ZWRNZW1vcnlX
aW5kb3dPcHRpb25zTGlzdCh2LCBuYW1lLCAmY2Ztd19saXN0LCBlcnJwKTsNCj4gICAgICAgaWYg
KCFjZm13X2xpc3QpIHsNCj4gICAgICAgICAgIHJldHVybjsNCj4gICAgICAgfQ0KPiAgIA0KPiAt
ICAgIGZvciAoaXQgPSBjZm13X2xpc3Q7IGl0OyBpdCA9IGl0LT5uZXh0KSB7DQo+IC0gICAgICAg
IGN4bF9maXhlZF9tZW1vcnlfd2luZG93X2NvbmZpZyhzdGF0ZSwgaXQtPnZhbHVlLCBlcnJwKTsN
Cj4gKyAgICBmb3IgKGl0ID0gY2Ztd19saXN0LCBpbmRleCA9IDA7IGl0OyBpdCA9IGl0LT5uZXh0
LCBpbmRleCsrKSB7DQo+ICsgICAgICAgIGN4bF9maXhlZF9tZW1vcnlfd2luZG93X2NvbmZpZyhz
dGF0ZSwgaXQtPnZhbHVlLCBpbmRleCwgZXJycCk7DQo+ICAgICAgIH0NCj4gICAgICAgc3RhdGUt
PmNmbXdfbGlzdCA9IGNmbXdfbGlzdDsNCj4gICB9
