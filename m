Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B422333A;
	Tue,  8 Apr 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125327; cv=fail; b=Xau+gEMoNY7FtK//iiDt6VTUCSuhWwOoKIyKvgt6dWLQN6yEfK6C/OjAqJl4g4nYDHLVnHo2iYLLXjAVLPrewDmm07b01NAJzaq/IJRAlrYL0V1fvJHT4XDpzDTcR9rKncRpGP3LSWmtdlaVOjA/0B2YHDkBZ0RrqAIztVMRIsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125327; c=relaxed/simple;
	bh=4dOgFPIl58btPMstkr8HuD979VrYYXXfPzOvCJW1R1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KIxjsOa3VMadWW81x4MXXa46Bl+wz5Er0YvmJDcEIZHZcCGQ02BJgF3lHDS/SFX1uUEHxhmpn2HIt6gdvoQFDcPx3drCj2YlXizeVymniwGkbAGmbmU6rsIY60/5Ejkb889i6DLYx90O8iBYoAXQ5oHWd5Cgo/0hj1iIn+uq2wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gwU7PlK/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RuYMmJuR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gwU7PlK/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RuYMmJuR"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538C6eE4025767;
	Tue, 8 Apr 2025 15:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qBFuC/UWsORT62JZBC
	DpYCfqBv/nXgHOW4KaKjvs1+Y=; b=gwU7PlK/6l8mIZXbERH8d9Zlnx1ha3eBfe
	yD3a49iOCjhz9RMZIItOhOs/cRMbQ8KLG2TKMyhg8y/KoYzsGz2qe7B8+zK6Xnk2
	R/rZVx4wAxlRiHX5WST6fThw08+dK0VQVW/tS74XY0WP+olynty4KE4DJ1AuDi8U
	o8XfHf8fQvRS9SUvcfbrIH/bChAdfbwH8Y2yActgbpneCKRB6JcK8HwVkwreeBN7
	dMA/6Rybp1dkxvzmpYTmMfu7/26QvlWaMbG5IZJQn15v0FpEES7KYhV6ftnDcH7l
	G6I4VCQpVa6rYQg8B67/jGhOBXGGnfGILDgi3+mxr8BdKjzSt2dA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4sw2gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 15:15:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538FDpxq023950;
	Tue, 8 Apr 2025 15:15:09 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfqnpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 15:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKghyTSM1frl0EQg6Ufi1NaPtVDrIea/r51y7eEZVUVHFrR7dndoKx+kg8UqztI86mtl1YwjY+e7+aM+HlQJYV53LCxRfwp2zaHlUkrBbZ1fPq3Nt9mMWIlDQNriLhXS/qwg93b/smUnVmkEXJFNHhp2nQCG46lRFr6u0lzyPRp9z0JJoDhHumut6xoL20cTMhehCWXwD7EPUET7XWQPGqDkTMVYUB5eQOkfmmK1SEIpMkFj49bij9lLenRxAN+Xr/ks+YHY3dPvHPRJfsCNJAzFmMlwHDKqHfL2n93XO8JamP+Gyl3IC/ksqBdEjYPm7y9LCLm4xLBqXzpTcdim/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBFuC/UWsORT62JZBCDpYCfqBv/nXgHOW4KaKjvs1+Y=;
 b=f7fZafadSIIhrwN1IW7n4MScF7Wmjf3fkRM0QbTKNwW1zaQ38MP9ljQnI2D+x6Dh+W4GjgHDqKFbb2DUk3smriGh8rAMLBCb1r8g1oTb/k/uEDSJ0tZ3syLWAYIe7Y0P5zUOqf7PzO1K+kUTznguYbGjSEHdqv0QRmxaRiFYrYO2YpLlDH+FYYexmavwesni9jTxVBpOgIvN/V0AcmRTVZxyiFoBk6vHn5+/3OM2QZqPcJvF4zNmQNG9paIbRRZ8M1H1/5anwZFOG00kAjNWE25w3ilTV1LerCOwbYSaNLafnoVRJo5X8uZxNDAI+c56pbi/2ppiJ+ljZ2KzsysafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBFuC/UWsORT62JZBCDpYCfqBv/nXgHOW4KaKjvs1+Y=;
 b=RuYMmJuRJvmePGN80SkwzeMJpr3RFgi+ez8kdhzpt5kD+ST9iSHuHelQ9nIwswtPEc8106m+e9bqXjvq7cpJ/uKy64clPN7r5nRF6ah13gZlA4+sFloZTMSmtHmUyr3olGjYdRK9xgL4em+S3+B3bPjW/VqkFd+Gmtpq4HW1Kmw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 15:15:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 15:15:06 +0000
Date: Wed, 9 Apr 2025 00:15:00 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
Message-ID: <Z_U9dITzT6j0z7zA@harry>
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com>
 <Z_UbZ8yY7lbB15-P@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_UbZ8yY7lbB15-P@localhost.localdomain>
X-ClientProxiedBy: SE2P216CA0075.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5f1ba6-ebde-4ffe-d03b-08dd76b024da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NuOiBP1Z2ns0AOpJ+jBVZlHAqP8y3S2wvvVIna7kXwbUNzt7pokgLav24P75?=
 =?us-ascii?Q?SVbGxoAnqfRbMZIgkqA+uvaXqx/LGGsX5+vn97cO+Pn3NTJXVa/Wy4DfoAsg?=
 =?us-ascii?Q?E0zQZPBi56MXZvHHbN9vzeSaWSux9IGIXmazf5sk92tQgxKWVTD59XFNKb3r?=
 =?us-ascii?Q?nFChvCIkvY4icz/jX3D3fpFruRDbvu4C1cpjjVWqPYyT20o3neAihhnxBBKx?=
 =?us-ascii?Q?xPSctZumVeEk6RgT/BwbUysLjQVvFN8VyGST/ddwBl/JYwGN7LTg7ibOZFSK?=
 =?us-ascii?Q?Iq+Mf0Qybop9jNfr4EYqt1SDi7EcVnmxeb9cPQe3k5r6tlf/oYuSMtoYCMaW?=
 =?us-ascii?Q?IORnQl3ATq6V4HnMqcxAbLDFH2DoMT51dggiJWXS3c8rp6keWvt9kfLn91Q5?=
 =?us-ascii?Q?6akOZr/ACoa9gSrh6qQFKpRwR/K27ZtgXJessPrE3kB1L3uO2WmwZtBJCa2K?=
 =?us-ascii?Q?7gFHpwiCP3GVZco8wqJrIBY+Jx5+stUl9lFHyZkEOlvhg8XsQs3/ei3m3iGR?=
 =?us-ascii?Q?Mpyl5DaNu6vIHFe1y/mcqjYnhWJ/NQxBskG8tA4INNjAUX9NK1sgbNMTzcSg?=
 =?us-ascii?Q?V9/m3gx79q7/mBUXTTCc+oVoAqwKjZxFNrSgmqgu4BfR66NCKtn6zT/e9vSh?=
 =?us-ascii?Q?B4JHj/UKJBvql7zOc/7jHCOl8dgSvtWlHL0cce1xmwxDjFTVXd8JInZyumPh?=
 =?us-ascii?Q?Leyre0DGvC/6eHRhun8EwZRvmQFO0z6lKK4xJ2YLnBrg5fVdDK8kSftKTrc5?=
 =?us-ascii?Q?sggYTeb06vqv7HUoSVxEJBWfcQc31nGNxBLqwQ2xKZW+FlzlqPD/+DF7jKvj?=
 =?us-ascii?Q?CM6Zpl+gzTvQwl0E5SpvMjr8776BpIM2DeUvmzK/3vRGSBx4caaKxjCp1lzV?=
 =?us-ascii?Q?SxlUHl2BOM+G7TTSjbNZfkoPlZb2u6RO5xYXuwX4DPBNPirZTlE17hRM9vdc?=
 =?us-ascii?Q?qmyVJcVUWfGcTDiwE1vW8sc3NtotAtkR2c1Ww7ohzb0u1zl2DO4mAgr1geG3?=
 =?us-ascii?Q?oLNxwOT2rZyk9wQ2l1OHLPPs1chJ2R4oUco2Pr1qGXdMvuV7DCTVPDOOvXDK?=
 =?us-ascii?Q?U6OMrVdNYUsecjo99Oe84uu5HmJ4zp/hAMFVQ14bP9q2zZ9qkh+Tu9WM9Efl?=
 =?us-ascii?Q?Iiy8l1WehD1YMOVa5XrL1eG9FDb1sM87DrLIrdOdHucYJpFryK/i601FttI0?=
 =?us-ascii?Q?jfWs7dvNhxF5wgzYrVxbzEQjlHBMcSInCPAL2xUrlcQqXE6FcCZDnZZySwF+?=
 =?us-ascii?Q?bwY6B8LsdnO7lYSWDE0zJT8gbZpeJnShF/3IHoBpKCzIp4CWVXEsYVe5NPTd?=
 =?us-ascii?Q?Sm2u8w+C0QRnJ2xKBubTaspeGQTGzWdM8QZ4fLBL0VFGbITYY05b2sjXNw+X?=
 =?us-ascii?Q?ve8jZgTFI6TWcEK2uaRNfZRDJzmx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+96kAkzxnXARO6dcgHVItRQdHvu11c1Rc01g56r7m1FwJFaaVg8ZvSNo1fm?=
 =?us-ascii?Q?SR75seVR3vN5fWp2QNEeIxv/UJvD3Xwxwbcn5853SdSMEMsFICly1y+1P8O/?=
 =?us-ascii?Q?UExWMHM+k/Y+XbjApeMSeSKudsnkHFH0ZNE46t0RwpTOPIyZpFC9J64cRFbc?=
 =?us-ascii?Q?x0ID/HdnbLJK63GR8t1vjt9naFBzlf7y5ZhOfe4bONy9w5LS2ZnbC8zJMo24?=
 =?us-ascii?Q?RRKRkDBE4+vnSgHedHF6xQH2/rq8PbTcld+yCyHsYYdh5Y1RcF3OUCze+HNl?=
 =?us-ascii?Q?SV5q/Liu44B9YCD0GmPOM7f/+Os/hY0VO7eoqgOHuaKQLakQP/wrkEbktfxI?=
 =?us-ascii?Q?BDo/ngPvtvwMKFk5QkY0ZbCSnvFqAQyaKebukml5jXXpzRPt5U0vJrSuiBQ9?=
 =?us-ascii?Q?FNAvMH0bZQr0obfszgr6JLON+xVxxWDPugkkYSkoszCQAU0NuW8M5zXCUf4L?=
 =?us-ascii?Q?KisXBh2aKfJ33qB3fOkGtwatarM7XLKXWASQboTeJfS9781hKexhgkgVoi+T?=
 =?us-ascii?Q?JTC4AE/LyetvPJ+umXy3oHqXYw3uO2PanflnFacXVb++TWL2pkauyuZBKD4Z?=
 =?us-ascii?Q?ygxsE6ikuumgIyFA/vhDB4AL8nuv2+U6rZhKDIp0U/OihQvDW/KrOGsb3+Mm?=
 =?us-ascii?Q?319FX7kHghKbuRXulpN7Jw2YojwAGh35BlvxWpS6PaCQTAiT0u6Fj4xO/b5f?=
 =?us-ascii?Q?CZMpxIMW0xRi/naUJhcMO5joAg5DnH5H2kT24Epr5u1vUJO5o3iwBrVGeiTQ?=
 =?us-ascii?Q?XBLhaLfie4jI58lO5usCortVtSq4u1wP3nRi2PpZIZf1oo6/pVG/O/ZdOFHR?=
 =?us-ascii?Q?1ieiA+URoJ/xAXh/YoIBu+YtZRV8LotFXzEKJMI8i3a7Nyv90xIrP3umRZVP?=
 =?us-ascii?Q?xOnRJNk37DVxZeh1+mDEnLpjqNmaTQRulOHCQP1iNkcNtA1ctRtNU82Bk5Mh?=
 =?us-ascii?Q?7YtpZUguSAcUBVp7hR1iNN7T0pzr7P/24PNt5ax0qGpTCYEMjKV14kBI1J4H?=
 =?us-ascii?Q?EhLfcTJ3ICT18CVZRTZJiFv7oTdDiJcMdWzTrV+a+IIX+pBhwArjOtuRqJLe?=
 =?us-ascii?Q?6/3edqGBtgf0aYl2BtWjtUGrLYZTsR0SvF4dx/bZJDwnSgYv9JFq5QVlCooW?=
 =?us-ascii?Q?DH62RD8gtPDJri1fdShgJYS3Mq0N4glTDSSUdwUWbl0C1EbSl71qt7QiNHNG?=
 =?us-ascii?Q?i7kGUENPtTylUqWwUw/MsKQyW/K0A9kwSEnDg17aigdGyFNHyARPFwHnvbha?=
 =?us-ascii?Q?CcDiP19yGz7/HPXvnpJBBgsknf7IakDpc6dKXymX/s1QKoI2K0b8xN0CjkEX?=
 =?us-ascii?Q?KmICKN1BbrnHJk8SwXch0mUhyFdNp1gFqu/xSXSRS1G3BMan73UuyIqpsyPi?=
 =?us-ascii?Q?9HmeMjcFJCUKkSFtEXkXffkg/IbyaaeUl5QAbE+P4huugNRtBXTfDU2GY/mK?=
 =?us-ascii?Q?Vq6FALuPKh4VQIo+STzGbJrb6UzYE+VHC/VsqaEDvgZOdlwEl2tQuAb4atkI?=
 =?us-ascii?Q?+s33QuDCrBqLSGCHxIQU6iiL0vukA06qTs5h9MuTkNz3d0j5V94svdcKtC/B?=
 =?us-ascii?Q?uMF7dju2H+nSvcUZEU6MBkAymih+jT0xKm2NCjmM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	moKr+QS7jQUAhm/JLZHAah5lIpLOIShg1UwEjgJtomvhS1w/IuWM7a8wS12/un0ckyfJWLwaC1WcdtIiUabIMZBnibykkUeHRLgT/WvJdMCKNfFJoqrbd1Zcn+26HI+YlQjyamTwHllWzvqUfWBN5mt8xHBSWNSwuSr2QX3ZZ/kafZKE7BAbVUjhhTOTWh5vbjve2JhxluafF+XV9SXYO4hF/xx/9RSM5C7FeBHzdz9NrsESfbHm3AWsoOi9ceCTD7K3ktkeXx+aDIBP6gBdUc20n0wfo1jeXcZzbva5jVl/juopS58Dyo/Op12S5ukS9+6FLz5VrHshpl8Rzc/UprG2tZe+mnPC+nR4TkSJ+0kbY39RH7V/BMEa+r/PKQsMtiFt9NH4sTDoMk+9rHFxNU1b9SGtLrHhsCXgWArqUyV3rbECurxXZ+8AAtmA0oJuW3akECfg9ENyvZ5cRQh5ntaqL95EdcImQahFGMN2NLaP+UX15rmwqEMqvV7SikvJEhJg2bYOmZX4RZ35vBrnlK7eMU+k+hwVly0NgC761pQzcEtWbfPCqoRXiVpz+Fgno2QZPYfNYu1iPJnFKId9au6recNeVHQNjCRU+rBLCWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5f1ba6-ebde-4ffe-d03b-08dd76b024da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:15:06.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1yZkKof68DdTD3tcpR3G+xXFEL/Jk91SsXZAwSE4GwHTsp/y1wQiZwfKc4DjfxHZawRcvDjCfygJu6h49KmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080107
X-Proofpoint-ORIG-GUID: gajLv_4QajIP86j9TVHEpF_d009fvbTm
X-Proofpoint-GUID: gajLv_4QajIP86j9TVHEpF_d009fvbTm

On Tue, Apr 08, 2025 at 02:49:43PM +0200, Oscar Salvador wrote:
> On Tue, Apr 08, 2025 at 12:17:52PM +0200, David Hildenbrand wrote:
> > Feel free to add a Suggested-by: if you think it applies.
> 
> Sorry David, my bad, totally missed it.
> I shall add it.
> 
> > Do we have to take care of the N_NORMAL_MEMORY check in kmem_cache_init() ? Likely it
> > would have to be a N_MEMORY check.
> 
> Yes, should be N_MEMORY.
> 
> > But, I was wondering if we could get rid of the "slab_nodes" thingy as a first step?
> 
> I glanced over it and I did not see anything wrong with it, just a
> question below.
> 
> So, if Vlastimil and Harry think this is fine, we can indeed do this.

Looks fine to me.

> If so, I would combine this and the #1 first of this series and add
> your Signed-off-by as co-autor. Is that fine by you?

> > @@ -3706,10 +3698,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  	if (!slab) {
> >  		/*
> >  		 * if the node is not online or has no normal memory, just
> > -		 * ignore the node constraint
> > +		 * ignore the node constraint.
> >  		 */
> > -		if (unlikely(node != NUMA_NO_NODE &&
> > -			     !node_isset(node, slab_nodes)))
> > +		if (unlikely(node != NUMA_NO_NODE && !node_state(node, N_NORMAL_MEMORY)))
> >  			node = NUMA_NO_NODE;
> 
> After my first patch, slab_nodes will also contain N_MEMORY nodes, which
> makes me think whether that check should be N_MEMORY?

Assuming that it's not frequent to call kmem_cache_alloc_node/kmalloc_node
with nid where the node has no normal memory, either way looks fine to
me.

It N_MEMORY check says it has some memory but it has no normal memory,
it will fail anyway because the kernel can't allocate pages from the
buddy.

But why not fall back to other nodes early when the kernel knows
it has no normal memory?

> -- 
> Oscar Salvador
> SUSE Labs

-- 
Cheers,
Harry / Hyeonggon
