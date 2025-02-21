Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE670807
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102779; cv=fail; b=boJ3Dxq1MbYYEXHNWw4Y9tQzXcrttpPMS7F5T3P8vgRJbRNVNn8UAvibKbceWsKC5bo9p8uA58hQuOqF22muvCvHRofZCa0n/Ch6rMU47XyO+HnnTFptgUZ/4de7ugiE2HNuFZl5nsu58iUDZ9W6DUEBwk26swy8wTqr4O5gu2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102779; c=relaxed/simple;
	bh=vC31xyVBUGDuFQq6GE3zx7RlE3rMANHYWIv2fW1yMVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cpRNhXZGmoceJ81/y/NlLyVoqEYgXkTf2QvTW2iXhO3A0pYA5+HEngGyLolCqiVMg+ABUYthTWtbcO9wxUR8GdqkrlQ9J7f/gLZyf+sSA0mTV0zRwZBNCIF/w5ufn4Wr6x5nvrx03ocQn+sPyeOfV38enXrkRn3klGRZj0niSjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jaPWAItZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QUnmZddz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jaPWAItZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QUnmZddz"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLrZJe028671;
	Fri, 21 Feb 2025 01:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VCekayddDci2MAU7L4
	BQoz4vjjR2EWYZkMaYqmbAfcc=; b=jaPWAItZfjjGd+WNwf/GpplnnhYq+VDony
	rJPeaGqAocUPX+KYjKAzBXKR6pjXMCSFEFPM7yPfGVw9n8A6Rn7fLHEYwTpOk8I3
	LCj0tUAq579e6ciHgjdVGtWVNPJ91gCcMAZdWgZOjq3iO8z2uP070YmT2dx65bVU
	CfgzXcxinomCkvUPwPnp+S1v/W059/P0FUU7YpQp6BSRBybHAgelCetY4dE06XoN
	SSBjZTfOJdJ2xWpsco4gFqF5Mk9zqOZL2LZacyxbDBY7eldqMrHJDF+tITcKMzu6
	TMphjxv+Z0I3K0dkCQbTmpzjoPjQoiGFd431y+ObNZrl2dVIza5w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00mwdq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 01:52:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51L19EEa026364;
	Fri, 21 Feb 2025 01:52:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0sr9mqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 01:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye2Y3BhAVvolduu4qGvmuPMMATX8x+ZPEmoRbxjPE0aaK8lj6J5hyuFC2A36/sEfufi9CuueM2eA0/ZAZ30qEbsM3tfzP/pdJxuAu8udAlYlLd65ei+8cj8jIB9e7a5Ap4SAHVL/9W4aXWuWQ0MOFesTpyuUmgURTEpK4bb5wqAcxw+WbI3JCbXnMRThc/fzQv3hZGSLHjOEhSRqnoOvpkuilpcT0yYXDgBNLOYGAcN9Bwa34ovmnwmReZgTShkhMpFRykUgxDDh1kJEI4ScALlIYI+sRcYaJggWAYDLIwZ9O1f9foj1LfolGw4swQse4Gi8ITfOmPLMAybGhPkYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCekayddDci2MAU7L4BQoz4vjjR2EWYZkMaYqmbAfcc=;
 b=w+XA75IIPB1hLTxP/+uYQgtBqko8o/IyyY8ukAxI7FckMY6HEut34dxOQUNx8xNQQ1iRa1LD2hgoNVnhma9nQX1PUW7lOMBGh2i17Egfm3VY4IOOQO8EvwSYPIKPYIVSiNO8CUmZwDeMjo0ZfCFPBVdQfYNi/RTmky4CeVtn9uIriUnSRx5k12/aSWDM2xDa4IlHKkRwc1RbALlA9YaUG5Cr8NsXQh5Jdg3p/UbOsnr09ceGSt8/mGTL4aQf10pT7ACWwhVqFJnlOyPQ+yNMxJOEFIDd0YFe7xU6phf9gZxSCZl7RLwo5NZit41noiRDC8GfPo+AxvW1iNeghGNOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCekayddDci2MAU7L4BQoz4vjjR2EWYZkMaYqmbAfcc=;
 b=QUnmZddzDXgYDM+ACZEdaVLe/SRRuJvSwIDYxP8vre9ZaewCWEQC/Rws7JLpneHaqf52ujKIIvaIHFdNU2iYlHdrUWUYIT79rTxNw7OqGppPmmf8bBsq+s6WCz5aXnebWOdtkYMM8u2sJSwS8MrbpuqgqfpALXJjmjswIxQ/FcU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6483.namprd10.prod.outlook.com (2603:10b6:510:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 01:52:17 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8445.019; Fri, 21 Feb 2025
 01:52:16 +0000
Date: Fri, 21 Feb 2025 10:52:09 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Gregory Price <gourry@gourry.net>
Cc: Byungchul Park <byungchul@sk.com>,
        "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
        Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z7fcSSaa4CKvxQ3V@harry>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
 <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
 <20250210071741.GB39454@system.software.com>
 <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SL2P216CA0107.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: e1de59a4-88d6-44de-8964-08dd521a5e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gY/YZNZ1p3nzcSGiZEoZIOEhv99c71g11GF/7bvLkF9GHlo+Wn5rjK1bFdHo?=
 =?us-ascii?Q?Xy2uUkBRY5NMOOa1HhytyUHRXwnDjcZaf0Mn1Czn6N7+vrTccr087QCTeXjm?=
 =?us-ascii?Q?r14821cEdWnPDOADneuwR+6xQi9v5+a8ycoT651K8tToo0sryh42PAt6iy2R?=
 =?us-ascii?Q?efw2dLZxyaC7uy1GKmYj/+9cGkVnPKExpawP4qXWE0YoO+kOSmJ+/WLaoCvh?=
 =?us-ascii?Q?hG1x99wBFfbrEke7y6WkupxmfpaIMYQznZ7Y5RwKELrDg1kpqddvufxMwRZf?=
 =?us-ascii?Q?dLRXA16y6vysfTtLaQWnXQLTXM+4WXYulUNFay1IG2Y+B/dvt+qymDj5scVF?=
 =?us-ascii?Q?e0pX+hdSm5c+Y/ck87VvScptCUkCpuZxlroTEx9MsFMEGWQBSsExDc6KGQ08?=
 =?us-ascii?Q?PkOZf3yx/Cj/SCBXBkV5sKaaYSW747tMk4JU0FjmMXEJGDCTxIis0uPawv5Y?=
 =?us-ascii?Q?6h9Ifum4DZNNvmccKZjS4u23+VKeFi6+rMALpSzOn/oZQF++rvqGFKG1Jcjf?=
 =?us-ascii?Q?TiqE1QlCfL+XL9sjbh+pFHxcHSuWpAFaKwr1Y3WkAy1DMg4I40P7NWbGfdCi?=
 =?us-ascii?Q?WTH9IyoZntR/6uRHh1Sanpul8J81V7FKDj5AwHYpcLtH4l+PORtE/bZstcaQ?=
 =?us-ascii?Q?ZfgChD0BZvlH/peo/P4bog/oA95Ygpk2Dqgq3CPz+kfqOkFzS+Q9fXs0Cs8Q?=
 =?us-ascii?Q?yPmL0BBFO8B+ygm8oNRZT4MlBSL441C/73DTg5mLt+3KMWemgJVDZRh/Cncu?=
 =?us-ascii?Q?Potj5Psb15elrgU26YcG/VjcslSUjc1QPhgbUNCYZZ8x4UIVCeqORlYJ61Vf?=
 =?us-ascii?Q?HPleazoQrUQyNrEwSZm2huCSf7jiAu05RLjbZHL8pOl/TswCisJeSU08TWHz?=
 =?us-ascii?Q?wUaFScckgBJEY4UHWF0vWLv5YGwuJVHOCoH2vTCqSTtx5vuRiFUQi8Mk52Xc?=
 =?us-ascii?Q?MLxwDWV2ioyvMYLLdbqfRT3ujMFFhreP35u7IFP2rLi7CwTGzRfOO2pI4Esh?=
 =?us-ascii?Q?x2K/g6xFIE0z2tHoU9wwRwN7keNpmfqeJiqCF1+aIU0ikXUnII4rT87/Qdih?=
 =?us-ascii?Q?6SvGCUoxZikSR8+3/PFQlTxfuAlGUWVUVtJcEKwTq18wdALL0uLtqdoBlqHZ?=
 =?us-ascii?Q?79aDmvaYSSrFo/ZAuZB8W6VBfeoHtCUNU+lVmF9ULWdeI7/p3aJCVYORRohU?=
 =?us-ascii?Q?s92+dFxAegAY5NA8jJ4sHTwbG/l/KgnLxlZ8u0RTQjmPgBUOv7cyp1O3xrBb?=
 =?us-ascii?Q?iim0y04Xy83jbOJ+us7uvJkgojgUxIi7gNHnQ+A5pVaLoz943CzWIz8C1IQP?=
 =?us-ascii?Q?tRumMJTrRfB89E022QRZBygXiMauXgEVG+xXWSbbPaBgVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SyEVPaQ/8/iswPmcjJewkz7OmGhPbFniM5mtxx6EkD3y5MJ9UWbRWy+xZg7?=
 =?us-ascii?Q?3XfGfzejtdrsGkpf5GlF6oDIgRcTFH0DHOU8YcwcsCvTxkPZTHXk8ke1jRHN?=
 =?us-ascii?Q?Gg1OVrvaQlfgLZLQDSIP2UFZaY3Q25I2xUu2GM8j7Gx+n7qvJYAiVw+tl1OO?=
 =?us-ascii?Q?AVo4rnyNcWhfHRTYA5ARikT3PJyx5eknFjPlUDUp2mpzCR0Pje5PME5a4eVX?=
 =?us-ascii?Q?sovdmUl6E/54YCESwP5jz3FrTE77Jw8ocj0tIqcxImR+kSz9/qWUXmXdeDoZ?=
 =?us-ascii?Q?SavFLMsP0szkyNMCcrHDn9T98m6bTX74QMDEyyIDdeyXUgR0JVtyCrS3Y6yI?=
 =?us-ascii?Q?3qpeIetSBjkCwBUpeAfhmTJ3/WEmIAbQTzQ10VYftKnw+ZL8qS1R2BmyaQoF?=
 =?us-ascii?Q?yk541WEZp78FdMNQo6Mz2vZreTT8KDj48DP6CL8p4CxIXz7kSU0O9FclWH7x?=
 =?us-ascii?Q?D3IFe9wRcVPDArhVGtnpw5etLI9/xldGAIQepLeWlLv7W55Q+x46rslgFf3I?=
 =?us-ascii?Q?4IPsngHxxQPA6Ki6gMiXnNjCePCBnpgxzkxFrgn0o5NQjiGO6iDo53mh4QNO?=
 =?us-ascii?Q?KfQSMM1rrArNsecx8H1KyXFcY/tUf8f9WJ1mjVZBK/JRy31ihd4ajKHzFrwY?=
 =?us-ascii?Q?GBBxhKtxUweuTIwkhwK48gI7OzZ41IpUprm9cGehX4Hkyq5QXhu1PzTG3m4h?=
 =?us-ascii?Q?XZKkQdLyBvlbl3bb/TYbz/XposEoMW+gV7/cLYzrYmjBuepOAaNsroK7mw+E?=
 =?us-ascii?Q?8O6/u+Eu6N84SWS0CFZiwtmWAbLwTSlKFfdnlkinDuP6uEc6djMwmY6cumD2?=
 =?us-ascii?Q?GF5S9ZX5eMdIjX+ubmgNRW7rKt2DHtLwl2wB5Win/sTkzLSEGtopEtT1DdIZ?=
 =?us-ascii?Q?hF/IyM7Da7hbEFfMe3hfUKuh1QQqfdNKRSdgpGT/CEvdk8KTyVgUeKa9H7rA?=
 =?us-ascii?Q?pAww7EKpCSUU+oWRmKEsMlvWjmkYXHV6hPUFw0XuymA0t6qT/9N5Cd3jzR6/?=
 =?us-ascii?Q?l9g/0D5QEHoq9m6M4zJ5WqVsQz5LF0o66RYQ4nKDu/UJBW4wn8jCm5LIB4MO?=
 =?us-ascii?Q?CAFGzP5u8dFQ1mfs3bYRSKjXQ3g16WGPViNJ0t3gLZGLc5at5LiWuehSPCav?=
 =?us-ascii?Q?ZXWBEQG1OVhlOQI18g+6szfs3Zzi7nCmTfttxyEKdDugUuGCYIkCuSZTjH1Y?=
 =?us-ascii?Q?9pRHUAxkVZPTbZPgd8GZJCqetUIAKLyHo7a3R30exR244GiHPyNzKZ8tVNlm?=
 =?us-ascii?Q?5NWoxcSHDuVP4XvT3DEbsgFQpr51uyCZX7B8erzDBx9E7eqo9NaKIc31fyT5?=
 =?us-ascii?Q?Qp+tzuL43LGWEy2uKmlvZA4i/ySklnXAbEdaFjml1veMqA+NGaeZFtWvL0F5?=
 =?us-ascii?Q?+s6duIYXVI3RLELNwrUHq5X5s47Afenz7IwHxuqNwZJTOJ75n/aaZz/P9zsm?=
 =?us-ascii?Q?1LR2fVBN350Bd66uGebaHqWDmd33Eob8X7EMXEu4iYBT+7vdfOmZAdy0piac?=
 =?us-ascii?Q?E1GHDgPoHK1UsQBMA8ajPWdOYlLDCLkU3BIE/J3G9Kv0eVnkOup+349lsdgy?=
 =?us-ascii?Q?KJoV80UzJxfE27ayYSheaTQqCn4RtBXWmRgQ+MQT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJQpTwccqCfIYlHY5/jrLVYhTKjSaxHHY9hLUov/XTdSaXDeJX4O8NbuS2tx/PpoVpmQvuFlY3/3KiDnBklpW7fnDdiK8wKO/foDa2jxyUonVQFHhSYtpJL5lmM2qcE61QrbRHo8s5qR3V8cePzp+CYaFnHJdx/ixo1cpjBRRlNtBbFY5F84D3UJwHCwaPrpj7XSXhEzEYRV8WQhzh+PATyfHjaJqE63rc07KnzjnEVCe+zTwrqj29lkxfd87/1rvxT7h/qfUPSWTuDyXbkfaU8WAdAttIYBhYqO49Qvz1ltnOgbdLitSkfj3IFcIV2ztZDMxvvTHZuyrwWGpoKrGHLZJtkHCx30Vn4MyruT52L4cEoljqWF/bhxe5zY84ZV8RVKid60UzvsgUeeMGXKKt0S5M92x8zI8pW+n2YqCo3cmF/nzw+XHOv1pl9Er3Q+AbArBVMZn0Xazqo8fz5HsPRBML6FGXuineNaIcAvqfb7ZQGeSnuT96OSzBNyqs6oz4CWclTYaPHPSkz1p9LdAmH59JgnFBE6aNZuKCfND/eANFBS13tlm0zaTy/hCTQsufw8ryrzzpFt4QHjK05yZ8v3c634Cyi0w6NK+S/VcDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1de59a4-88d6-44de-8964-08dd521a5e58
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 01:52:16.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P353zkrrLL34iLdEtp6knb8YmihiGsevSa0CFPU0aHuJxjpwNX4JVVuqR4Zpc4jxpYFTzXi/PtL7i7riz2iyvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502210012
X-Proofpoint-ORIG-GUID: JOnfAmCTbToSEdRsLVxTstge5ivvuEbp
X-Proofpoint-GUID: JOnfAmCTbToSEdRsLVxTstge5ivvuEbp

On Mon, Feb 10, 2025 at 10:47:58AM -0500, Gregory Price wrote:
> On Mon, Feb 10, 2025 at 04:17:41PM +0900, Byungchul Park wrote:
> > On Mon, Feb 10, 2025 at 01:00:02AM -0500, Gregory Price wrote:
> > > 
> > >    You can probably actually (maybe?) collect data on this today - but
> > >    you still have to contend with #2 and #3.
> > 
> > Ah.  You seem to mean those works should be serialized.  Right?  If it
> > should be for some reason, then it could be sensible.
> > 
> 
> I'm suggesting that there isn't a strong reason (yet) to consider such a
> complicated change.  As Willy has said, it's a fairly fundamental change
> for a single-reason (CXL), which does not bode well for its acceptance.
> 
> Honestly trying to save you some frustration. It would behoove you to
> find stronger reasons (w/ data) or consider different solutions. Right
> now there are stronger, simplers solutions to the ZONE_NORMAL capacity
> issue (struct page resize, huge pages) for possible capacities.

Hi, apologies for my late reply. I recently went through a career change.

I truly appreciate your and Matthew's feedback and thank you for saving us
from frustration. I agree that we need a stronger motivation
and data to introduce such a fundamental change. And I also agree that
it's more appropriate to pursue what can be useful for genral MM users
rather than introducing MM changes just for CXL.

With that context, Byungchul and I agree it's a better direction:
Reducing ZONE_NORMAL cost for ZONE_MOVABLE capacity, which is beneficial
for ZONE_MOVABLE users in general, regardless of whether the user is using
CXL memory or not.

Let me organize a few steps to pursue:

- Willy's shrinking struct page project
  - https://fosdem.org/2025/schedule/event/fosdem-2025-4860-shrinking-memmap/ 
  - https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
  - Side note: Byungchul started working on separating the descriptor
    of the pagepool bump allocator

- Slab Movable Objects: This makes sense even without CXL
  as migrating unreclaimable slab will improve compaction success rate.
  It also has been tried in the past by others, but was suspended
  due to lack of data.
  
  I'm looking for workloads that allocate a decent amount of unreclaimable
  slab AND performs migration frequently - for evaluation.

I might be missing some projects that could be useful,
please feel free to add if there is any.

And for page table migration, while it might be doable even without CXL,
we need strong data that suggests that it's actually makes MM better
to pursue this.

> I also think someone should actively ask whether `struct page` can be
> hosted on remote memory without performance loss.  I may look into this.

Did you have a chance to look at this?

-- 
Cheers,
Harry
