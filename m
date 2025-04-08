Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980D17332C;
	Tue,  8 Apr 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121952; cv=fail; b=SzpqHIGldjl/mDAFc3RykYd/dJIsfnriHmPrinEa+VpZlK5m114DID3aubiMhlAfmlQYJgDop6oOOgUr4iWqGjc/A2VzVAJdAHzm5w6Cl9HOqt/aBtz6ZGshYIEF9kmHXNFiYhbk1bri5vaELPIIqeGArHLga3XPPPV2Elbf5yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121952; c=relaxed/simple;
	bh=LSudoZmMoqhe5aiu0QQctx29krkVG9MSx0McRQRRZaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PGtREp/ABa98EX6wEOOwelbvqKnQYNwNwzkWyl35yP/FQy2JvHixP4u33yT6gIs+902ndR9sZ35/XD6o/l4BMOMZRp9WOa7KT3IOBoiQgBX7f6wzvZ+OcjpXK5YmkE+K4sV6GRXLFr5+UVe9BnTQMDkesWG87WUZxoVwmJ92XI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VvMcdMpb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gGYg9mHb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VvMcdMpb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gGYg9mHb"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538C6fOG025773;
	Tue, 8 Apr 2025 14:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WLDWigHvwUJre3uoTb
	EGM25fKBOSj7OOKj6Z0sP0XUQ=; b=VvMcdMpbqRTak2t1hqeJUwPI+LQg8Zorq2
	63x9lYc0FbpPycrL7rFEJSnVmLFG/LZWmEP9T4LBltrwhrdKIYFb7FxkJ7ZztAM9
	MbXK1w/bCDceix+bpaacwtL7kfwZUdXjU6sySKF/PIyFoykYd1fSG57kS9BSklRy
	Mxno88q/0NIjAAO/x2nRWLTNE+K2jeiSpnoLZ/LpQ+Ph/EECVQjLLY3dOlD7uYp/
	cUMh6owzEQCIwiJ7LXt+nsrESQijjOchXzlWxfl45/yQ0/BoPFrywhT2zEGllH0j
	Y3l6w3P1x1NVEzHifDL9ZH7nYqOVoV6gGIdvXK0ua8WHv8bpBTfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4svwuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 14:18:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538Cvdt5016286;
	Tue, 8 Apr 2025 14:18:48 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9be48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 14:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbVQH7AVWjfChTjynp6Fl4gmCCfy8RWBpi8xuTsm3H7Q0w+xFxgrg77HqIF6Y5nFXtGhPCiG4fTnFDwVWCehF1e0aTr3z1V8oRT2q+Cw/lS19qOKAhFQXDExMSNU6lAhPMQjBMcSCdZixIZDCSZoVpWo/BEmqJGHN7rB4zyjWTKxwzshBKzqHWCZU1J2Ql+19gfMpJXIUB811WLuU3AV7UIknTzJWBGDRXFLCbFzLal7ZOpX7TmRiQQ1X6ZrcHDeawMBmFOV7Sf5rSviEFMyp/YK3uyCdyUsQoGk9rRr500bw8Se3nIGEO0av//i0Nx6MDEYl40oZQcCJZVoHsFgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLDWigHvwUJre3uoTbEGM25fKBOSj7OOKj6Z0sP0XUQ=;
 b=APrJ3037n8mt3/+M2OkBMtvUw50o34U5JHXr82dufUTEOaLkElassVKQnLJT903NcYqpO9F9a99oaZ9B4wO16DT0NgCOqUd6N2vl+sV0Tjh9e6jux3sm3wBHRskoHmLflLMwM3XIs1qGeifygMUru3cRzJ4b+aQXLr1PRS9CbHy01MsN9u7lPi5sjWqsvtsbYOaW7K8RhRlwACYs6v/iK+y9+wdOGmCwhfuw+KQk+G3yhevPi1IlTGMjiuC/iWSl6nsyoJ14sdMlHBZk30azXKaF5BSWZKdV6DqB7gxMWvjdGm0ZK+vsrdIwy8D+A7Z2ROKay5otQx6Oie1+alO8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLDWigHvwUJre3uoTbEGM25fKBOSj7OOKj6Z0sP0XUQ=;
 b=gGYg9mHbNMuxL0Mcbv1qEWxNRgAi1dJkDAS9lSR0Kic4Pa69gR1ccNx/R83zsUrVQ6msFBxLXNkpOUgVge31KmTgLYwG4endr6/+/aJiRKxaWZ51BJVXLFE/VMu2wCjMZNaW2B8xihQT0M5ZOoB7nFSm/VLYsDuzf+k7rdnmb7A=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Tue, 8 Apr
 2025 14:18:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 14:18:45 +0000
Date: Tue, 8 Apr 2025 23:18:38 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
Message-ID: <Z_UwPmyxyu8YNLG_@harry>
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com>
X-ClientProxiedBy: SL2P216CA0085.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdd255f-6f9f-42ba-0bb1-08dd76a845b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpYzzfAAD8KzXCwNdjrEFYS3cUGwB1I2kB/Pv0T5efNTneIUSANHZ6Ls/zj1?=
 =?us-ascii?Q?zsgE9Rf7iu6Q2yy65TanpyMEgqXOmXSxc0ObThBt5vHGDyZSs5UztCGo6Bj0?=
 =?us-ascii?Q?zZlJCnjwCuLsJLWAo4F9+l//rQHn19/9NUvItU/xkDfqalmLa1NvT9FQCWq3?=
 =?us-ascii?Q?MV+4WDap4d/av/4LZ8A4yaclpuH1sxkpXTWNnG3mwu5gt58aWh+fHM8Q39p7?=
 =?us-ascii?Q?6gn1l+dyiiR2rkF1HZ6lnjObDo+6HpOuFvKF3QNwCay+q+i3TsTKT7ofWfcl?=
 =?us-ascii?Q?1DM5zrybXA5EHv/q2GzaqqSr0RBugeQZUjJSF+tY4W7nAMFP+Z5bAIl86KkN?=
 =?us-ascii?Q?5Q11G8veZAL+3P/YkaSh6W9MG1rdHnvJezX7/CdwcOmK/hGXjIzEWInPpv0i?=
 =?us-ascii?Q?+RZNK2wDPtLtQNGOXmNBVuHXOabPSn03yPWkbxoLzjqiN+zIOKlqi3YZRF+e?=
 =?us-ascii?Q?Xo+Re6yAVdoJ/aqjPBl9Keza05vJPwiFQurvslsTyiwdtCwwoN7oBl0uHVUp?=
 =?us-ascii?Q?b29altFysixWexUrgNMcp4g3cB1jT8rg5PuaFNu1Inrfl2MQ4ew/lCN25X4K?=
 =?us-ascii?Q?p3kgRDltGNTRVuZGOXtzYWmuizegGExnhaiBuRuSarOBmPar31G2aoHMzPYC?=
 =?us-ascii?Q?FDF0qwSbfAwLVGnmumOyQ+F5l/MWjGf0k2kGZs7ifn4uPI1/VsBsXS2wBJ+p?=
 =?us-ascii?Q?htp88uy3YrUTQ6oPePBmBzW7fFpp0L9sIdu5vGlhmVFNqQPiw1DqZ1iOvIRx?=
 =?us-ascii?Q?FEq2NDi3JsULtkrT2GKqFKXuke+jbwSwS/Y7ErCq/km23hmcdOzaw99G6Bpd?=
 =?us-ascii?Q?5lrAye0+YKqfFpyf00HC8ffHGOfeEC/6YLIkXBEh/TUYbhOMNxQIJRAaSQcj?=
 =?us-ascii?Q?+oGcMQIUySM5OGt50njsW6Gp6IUZKIHbfyJ04g9702ez7AAUqgKlpuE2mjlS?=
 =?us-ascii?Q?yZ3+j61Qod0MBQ/hN2PrZWyJq4Y5wgBN9pnMs1WQhNU3kUXKmcdlSKlPcl1R?=
 =?us-ascii?Q?S1/NKov7/pgeVoZj5prQUVjef2C/xtDHud13/S9Vq9VIp0Z48C+Uvv+vw0Pq?=
 =?us-ascii?Q?ZJZypefh4DVuqhOHoJs93irJNdCUL5aWFXd3ZZ6bghY47VAkZl9ZT5d1Jl87?=
 =?us-ascii?Q?I5I4qFgyOA7BsCHqC/zgV6aOqIhZGMeyMd0vATMQQgIY56IYVRBoQb5ozhd5?=
 =?us-ascii?Q?1i0tH5xhmuZ6k2nRkaWxLU++fQKGcnmj6hyjMTCtWmIC6RlNXQzxR7l+H9Lq?=
 =?us-ascii?Q?6Q960KTkRYvBPI9TWEBCRT9hIQ+/eleC9NjxvTQ+yq6DcSwIJLsZVvM5kiHe?=
 =?us-ascii?Q?66QjzWQir7yyqZHXVsEltofvmN6PRJQpsqTFzoL765uxPUWJE8yZjvlyNJC6?=
 =?us-ascii?Q?t/IdT54tbehQhY5uHKBhnwjRjEc7tpP/XvotQPrZLnX32Zhix3HreOQlrfcB?=
 =?us-ascii?Q?HNL66CMxNRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZs+bsFJmEC2OoWRp97w40xs0d6BUe1WfrjYQGag/rnP80NEATmZvb6CfgR2?=
 =?us-ascii?Q?I1faSyHvxxiGdjuD1cw19EgBREXH+/peiclL9Yt8hr1YfoWJ5Y2t2qL97xEE?=
 =?us-ascii?Q?4zHvHWkE5SfILexVbWg6B/cz+KvU7uJn7yX6qzygE9MYaos+/Po9KCA1u022?=
 =?us-ascii?Q?SUbSpYasTdioaQBBhSgTxfNg7bXrg2cnzibl5Ll+xZ/1M9HCkPAzVdbOeqNt?=
 =?us-ascii?Q?iv9voDkoT4qvwYmFoZgKMNsjOTYMpYkqds3H2tPszTbjpJUD3MY8yt0X5S1S?=
 =?us-ascii?Q?jwMBYQeICcyKklpqAo2lpczhJEDOrDC7XNrYWudzgjBsdOrNWD/9wC7n41oZ?=
 =?us-ascii?Q?78iseZwhxZzGEeRdLm3HoX/IJl402e+QL/FZOWJYJiYD0+5T6WQjjN13SHRv?=
 =?us-ascii?Q?l4DG11zyHb0yFHl9hq4Nr+vYicd+hiWqFLDYrQyUvpzn17HVD/iuy6BcE6C5?=
 =?us-ascii?Q?Xisb4n/wg4l0P7c+0V6toB0nTuxroNm6PirlU2cEAnqjnAXkslJ0mbJsJlEa?=
 =?us-ascii?Q?nxYkn2eDC4LyvBRyFuWMtTmCSApQN5AtKtlPdbMB8igBBjehoF9wIna7SXkV?=
 =?us-ascii?Q?oFH+rioOwN9UzZWldKxw2OTSlR//KkRRxXqrYtC0k08WVr2CPuMtEqIthTRf?=
 =?us-ascii?Q?u9bU5nWO8x5ngUGiDd20bHmI0DC7YhYQA0yPUO9rnDUgoa+0NFY+UxQXekGq?=
 =?us-ascii?Q?GQJyF37WvCgTY1u4H/+dpRO2noyfnBjpu2jNIBfvuQ9TEae6ZgFBG4y286TK?=
 =?us-ascii?Q?pa5wiNE1la23Ms5D0FOBCHGPPxn4XEGMaCV1jd0iOURc+swe2NsJRT6cVFbK?=
 =?us-ascii?Q?KSTgdAMJA7C+1GY83FdNdFTE7oT6jBgFizxPJOAvxmMVA+39JUBHdIBik8It?=
 =?us-ascii?Q?OC+tX0FP5U0/ylB8QpdE/AkVdcDolblc9QHEStQ3yTxPEAKMB9HnZfYq4ynK?=
 =?us-ascii?Q?dP1GjsKYlGZR7K9NQYeH8nnJ+q+lqO5zoWGTl7UWbf3xXglDhUi6h8QZ48DI?=
 =?us-ascii?Q?zd0VxpmvhYfXPKVmF2GHL0X9+JFRmRDIE0K5ZAtNJzBIaY7M6m3jR0JsSDbw?=
 =?us-ascii?Q?ZfyLDrQ9zdELX2lzg5N5dsmeEykV72f8cR7ybIOB19W6qoa+jc/9kSQa/dyI?=
 =?us-ascii?Q?VRJYE1WPGU+oWnjRPMXe5N8ZymUTDMIqli7JL8jWXcIdTpPyzTV0Hp48jl/u?=
 =?us-ascii?Q?BtNUGo2UCgfb+4vfh4sp6sUanunKMuoqf9RVSNrJrXxLjsQCpi3FgSTB0c6q?=
 =?us-ascii?Q?vNPgoHMi5xRL8aDAQ0cqm0XsLW2RDEFfXkUTIX5xWSZEQb9ftYIfkjPEkfQs?=
 =?us-ascii?Q?FuEfD+e/uO9J9F5v2gWwmShsDDap2/X7xRoor6qxa2/bhyTWMBrBOxVBqjyO?=
 =?us-ascii?Q?XJqFx/5B3Vu3FOyyMdp6VV72bhOeigdkCNN6x8n7DM4yIZLlvFuZNDqecTZu?=
 =?us-ascii?Q?8CaFTp8jzj6TPS0JEkxiwEfquDXd3+FOaXBzc6oZ1Z4EJcwXr6aPNC+AvPXN?=
 =?us-ascii?Q?cakPmyUGup0E1yEMIrMgL9Tw2gibEOaockLIaSpkPrnHHcPTsE8ilXj0HnIL?=
 =?us-ascii?Q?sCi7KQ2xKFe7AFaUnb1WxEPkQOvbOCKo+GqSB3RB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AzyGC1STxsTheoEClaFDVUx6YmNGVq4gRe9JdctnUmznZEitTHpFXupQLDKXRxJ4A4HHDqzlEw0Nndxxk4QzW5Ec0CXRebJzU+CGDhKDuunu/6QmNnL2ajJZ0FhczyiZMcRVCt9htwC8CxFKjQDl2lzcH5Ibuwpzym7aO8Tqh2UHb8q/4+z4fkRi6fl0D1knMK4I5RZzqFgVx5jLDDUu71/unsWmSD+XLw7j/IMkgYiEAIGNSDuUKiVC2xIu8b0Co4KBNrw3fCqdTxcwpxVj0ipft1Hff+opjglnjfB0TNWtZPN4o5ZiVenyoJ9/Rf9gl1UswjWFvgmCK2JEsiR4PWvxqzzn/8BzwpaXkJAhVtq9aMSRpBkZ+ovshtJYzghDKnJIuy05FBe8bMdOdAG8x9wZln8p+G7CZvlBOCbiPvbRDnJ83uPdGp2JV4hPFro4OLqT+brYn+hE7lv7J8iXviKLLxPz2nFmrUA8SxFvkHHoYmeoSSijh6GJTiwDjFmnkrU9FNZCjbJBsuIjKhP9gDRuIXMSKCNu91c85/yWHWlRKDrReyzzaXdRXx5ufTm8ZYgTTi/EGFhzuqe1C2882Bp3WVZCGaLcGzStTSa2Q2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdd255f-6f9f-42ba-0bb1-08dd76a845b2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:18:45.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e0Hvojio707Gcdsxob12ngIbHF6G2CN//UfAJ/L6C147YT26jDmzjNbk2uH/MmnflI5IrcDJUEIdM479Sp4ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080100
X-Proofpoint-ORIG-GUID: DPyn5Sfd4IkdQ0Aihe7iUh2Bud_Pd7Rw
X-Proofpoint-GUID: DPyn5Sfd4IkdQ0Aihe7iUh2Bud_Pd7Rw

On Tue, Apr 08, 2025 at 12:17:52PM +0200, David Hildenbrand wrote:
> On 08.04.25 10:41, Oscar Salvador wrote:
> > Currently, slab_mem_going_going_callback() checks whether the node has
> > N_NORMAL memory in order to be set in slab_nodes.
> > While it is true that gettind rid of that enforcing would mean
> > ending up with movables nodes in slab_nodes, the memory waste that comes
> > with that is negligible.
> > 
> > So stop checking for status_change_nid_normal and just use status_change_nid
> > instead which works for both types of memory.
> > 
> > Also, once we allocate the kmem_cache_node cache  for the node in
> > slab_mem_online_callback(), we never deallocate it in
> > slab_mem_off_callback() when the node goes memoryless, so we can just
> > get rid of it.
> > 
> > The only side effect is that we will stop clearing the node from slab_nodes.
> > 
> 
> Feel free to add a Suggested-by: if you think it applies.
> 
> 
> Do we have to take care of the N_NORMAL_MEMORY check in kmem_cache_init() ? Likely it
> would have to be a N_MEMORY check.
> 
> 
> But, I was wondering if we could get rid of the "slab_nodes" thingy as a first step?

The following commit says that SLUB has slab_nodes thingy for a reason...
kmem_cache_node might not be ready yet even when N_NORMAL_MEMORY check
says it now has normal memory.

@Vlastimil maybe a dumb question but why not check s->node[nid]
instead of having slab_nodes bitmask?

commit 7e1fa93deff44677a94dfc323ff629bbf5cf9360
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Wed Feb 24 12:01:12 2021 -0800

    mm, slab, slub: stop taking memory hotplug lock
    
    Since commit 03afc0e25f7f ("slab: get_online_mems for
    kmem_cache_{create,destroy,shrink}") we are taking memory hotplug lock for
    SLAB and SLUB when creating, destroying or shrinking a cache.  It is quite
    a heavy lock and it's best to avoid it if possible, as we had several
    issues with lockdep complaining about ordering in the past, see e.g.
    e4f8e513c3d3 ("mm/slub: fix a deadlock in show_slab_objects()").
    
    The problem scenario in 03afc0e25f7f (solved by the memory hotplug lock)
    can be summarized as follows: while there's slab_mutex synchronizing new
    kmem cache creation and SLUB's MEM_GOING_ONLINE callback
    slab_mem_going_online_callback(), we may miss creation of kmem_cache_node
    for the hotplugged node in the new kmem cache, because the hotplug
    callback doesn't yet see the new cache, and cache creation in
    init_kmem_cache_nodes() only inits kmem_cache_node for nodes in the
    N_NORMAL_MEMORY nodemask, which however may not yet include the new node,
    as that happens only later after the MEM_GOING_ONLINE callback.
    
    Instead of using get/put_online_mems(), the problem can be solved by SLUB
    maintaining its own nodemask of nodes for which it has allocated the
    per-node kmem_cache_node structures.  This nodemask would generally mirror
    the N_NORMAL_MEMORY nodemask, but would be updated only in under SLUB's
    control in its memory hotplug callbacks under the slab_mutex.  This patch
    adds such nodemask and its handling.
    
    Commit 03afc0e25f7f mentiones "issues like [the one above]", but there
    don't appear to be further issues.  All the paths (shared for SLAB and
    SLUB) taking the memory hotplug locks are also taking the slab_mutex,
    except kmem_cache_shrink() where 03afc0e25f7f replaced slab_mutex with
    get/put_online_mems().
    
    We however cannot simply restore slab_mutex in kmem_cache_shrink(), as
    SLUB can enters the function from a write to sysfs 'shrink' file, thus
    holding kernfs lock, and in kmem_cache_create() the kernfs lock is nested
    within slab_mutex.  But on closer inspection we don't actually need to
    protect kmem_cache_shrink() from hotplug callbacks: While SLUB's
    __kmem_cache_shrink() does for_each_kmem_cache_node(), missing a new node
    added in parallel hotplug is not fatal, and parallel hotremove does not
    free kmem_cache_node's anymore after the previous patch, so use-after free
    cannot happen.  The per-node shrinking itself is protected by
    n->list_lock.  Same is true for SLAB, and SLOB is no-op.
    
    SLAB also doesn't need the memory hotplug locking, which it only gained by
    03afc0e25f7f through the shared paths in slab_common.c.  Its memory
    hotplug callbacks are also protected by slab_mutex against races with
    these paths.  The problem of SLUB relying on N_NORMAL_MEMORY doesn't apply
    to SLAB, as its setup_kmem_cache_nodes relies on N_ONLINE, and the new
    node is already set there during the MEM_GOING_ONLINE callback, so no
    special care is needed for SLAB.
    
    As such, this patch removes all get/put_online_mems() usage by the slab
    subsystem.
    
    Link: https://lkml.kernel.org/r/20210113131634.3671-3-vbabka@suse.cz
    Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
    Cc: Christoph Lameter <cl@linux.com>
    Cc: David Hildenbrand <david@redhat.com>
    Cc: David Rientjes <rientjes@google.com>
    Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
    Cc: Michal Hocko <mhocko@kernel.org>
    Cc: Pekka Enberg <penberg@kernel.org>
    Cc: Qian Cai <cai@redhat.com>
    Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

> 
> From 518a2b83a9c5bd85d74ddabbc36ce5d181a88ed6 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 8 Apr 2025 12:16:13 +0200
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/slub.c | 56 ++++---------------------------------------------------
>  1 file changed, 4 insertions(+), 52 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b46f87662e71d..afe31149e7f4e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -445,14 +445,6 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>  	for (__node = 0; __node < nr_node_ids; __node++) \
>  		 if ((__n = get_node(__s, __node)))
> -/*
> - * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
> - * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
> - * differ during memory hotplug/hotremove operations.
> - * Protected by slab_mutex.
> - */
> -static nodemask_t slab_nodes;
> -
>  #ifndef CONFIG_SLUB_TINY
>  /*
>   * Workqueue used for flush_cpu_slab().
> @@ -3706,10 +3698,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	if (!slab) {
>  		/*
>  		 * if the node is not online or has no normal memory, just
> -		 * ignore the node constraint
> +		 * ignore the node constraint.
>  		 */
> -		if (unlikely(node != NUMA_NO_NODE &&
> -			     !node_isset(node, slab_nodes)))
> +		if (unlikely(node != NUMA_NO_NODE && !node_state(node, N_NORMAL_MEMORY)))
>  			node = NUMA_NO_NODE;
>  		goto new_slab;
>  	}
> @@ -3719,7 +3710,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 * same as above but node_match() being false already
>  		 * implies node != NUMA_NO_NODE
>  		 */
> -		if (!node_isset(node, slab_nodes)) {
> +		if (!node_state(node, N_NORMAL_MEMORY)) {
>  			node = NUMA_NO_NODE;
>  		} else {
>  			stat(s, ALLOC_NODE_MISMATCH);
> @@ -5623,7 +5614,7 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
>  {
>  	int node;
> -	for_each_node_mask(node, slab_nodes) {
> +	for_each_node_state(node, N_NORMAL_MEMORY) {
>  		struct kmem_cache_node *n;
>  		if (slab_state == DOWN) {
> @@ -6164,30 +6155,6 @@ static int slab_mem_going_offline_callback(void *arg)
>  	return 0;
>  }
> -static void slab_mem_offline_callback(void *arg)
> -{
> -	struct memory_notify *marg = arg;
> -	int offline_node;
> -
> -	offline_node = marg->status_change_nid_normal;
> -
> -	/*
> -	 * If the node still has available memory. we need kmem_cache_node
> -	 * for it yet.
> -	 */
> -	if (offline_node < 0)
> -		return;
> -
> -	mutex_lock(&slab_mutex);
> -	node_clear(offline_node, slab_nodes);
> -	/*
> -	 * We no longer free kmem_cache_node structures here, as it would be
> -	 * racy with all get_node() users, and infeasible to protect them with
> -	 * slab_mutex.
> -	 */
> -	mutex_unlock(&slab_mutex);
> -}
> -
>  static int slab_mem_going_online_callback(void *arg)
>  {
>  	struct kmem_cache_node *n;
> @@ -6229,11 +6196,6 @@ static int slab_mem_going_online_callback(void *arg)
>  		init_kmem_cache_node(n);
>  		s->node[nid] = n;
>  	}
> -	/*
> -	 * Any cache created after this point will also have kmem_cache_node
> -	 * initialized for the new node.
> -	 */
> -	node_set(nid, slab_nodes);
>  out:
>  	mutex_unlock(&slab_mutex);
>  	return ret;
> @@ -6253,8 +6215,6 @@ static int slab_memory_callback(struct notifier_block *self,
>  		break;
>  	case MEM_OFFLINE:
>  	case MEM_CANCEL_ONLINE:
> -		slab_mem_offline_callback(arg);
> -		break;
>  	case MEM_ONLINE:
>  	case MEM_CANCEL_OFFLINE:
>  		break;
> @@ -6309,7 +6269,6 @@ void __init kmem_cache_init(void)
>  {
>  	static __initdata struct kmem_cache boot_kmem_cache,
>  		boot_kmem_cache_node;
> -	int node;
>  	if (debug_guardpage_minorder())
>  		slub_max_order = 0;
> @@ -6321,13 +6280,6 @@ void __init kmem_cache_init(void)
>  	kmem_cache_node = &boot_kmem_cache_node;
>  	kmem_cache = &boot_kmem_cache;
> -	/*
> -	 * Initialize the nodemask for which we will allocate per node
> -	 * structures. Here we don't need taking slab_mutex yet.
> -	 */
> -	for_each_node_state(node, N_NORMAL_MEMORY)
> -		node_set(node, slab_nodes);
> -
>  	create_boot_cache(kmem_cache_node, "kmem_cache_node",
>  			sizeof(struct kmem_cache_node),
>  			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
> -- 
> 2.48.1
> 
> 
> Not sure if there are any races to consider ... just an idea.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Cheers,
Harry (formerly known as Hyeonggon)
