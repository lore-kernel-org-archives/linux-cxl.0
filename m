Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324031DF991;
	Tue,  8 Apr 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124113; cv=fail; b=ZIwh8pH6AoUYvEGdjhv6qA0XKQnF+vBhwyWxGEwHisduOlaMkZcLVTgUDIixYCpGnSA4l8EiW4YAZgLA1uwDJyEyEH4npTq4AaMjFjsvI+CyPJoHdW0RXucGUfzZ+c/QITdcrIQ45sFSX/OdHnVQTftnrzvN0HrwP82MWcLk7+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124113; c=relaxed/simple;
	bh=BcdpWAVD5iVpG5fT3jW2DFYPJ2n6r3zcx9Os4nx1ncE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atpVawm6WIcx2ZSZqKjK2BOPB+fmhCR051shTol2f9VTs+v56mFGFBiNxBnSeyGSnVFpkW5wTS0nL5qe90OUWzKrWxS5xZO/0cm8tix0so7F+rYXd+qy2CxHdVbshjFXNcdX36aL9LuTIWuX6CXfD//3mgsOzc7u66S4ETw4Jio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=keXpjHpZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fsKcpMNY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="keXpjHpZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fsKcpMNY"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538C6eAR025767;
	Tue, 8 Apr 2025 14:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=o4EmLmnOXQthawcWUZ
	FPpX+eaVtpKCLrmn/tiLmwbAg=; b=keXpjHpZtxhk7zRQkA3+INr+EPfZMm/3pl
	jCv7P1MME/mFcN7E9PKYPe711SaIpSpa1ONYMU6BbxHqkqiWC8kgyhb5jBoEdExn
	6q2dpAho4HqTboQPV6PENR3C/ojJ50x/nAznw8V9xV13f2JNZnfQb2PvjATwNiSY
	u+X6OPY4QhO5T4467F/Hbd4qn3MKXTAWnhFLpOzMvdAGl8frPOKNVGffqVymSM7o
	JlJ5NESAdcF2RaTmnmo8o0QQcI3ZVw4nX7w5waXjbIeCvi7d4mwuoAdCoVg/HRxS
	FyaAr3fviFX5/bDOA6/hzyseGHrsPvGJ6TFq9SIZfcwrPlJPtsUA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4sw0tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 14:54:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538EFcvQ021216;
	Tue, 8 Apr 2025 14:54:53 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfq2d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 14:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq5nEmUcAiq0zkD8yWGU6mCcFcM6VJVE03hIRMXSku4sGZXbU/KDZi1/u/AokLP0WMp67/Ryqr/ri29XS8n0qVoUtdFIS/Z0kZrJO7eQEv5gAusIBwR4MxpQFvhVPEzUY9w08n1UfXuICYnSi3jbVsfjYwiO0mmSi04686H7W7EBQTfRaLHnQj5X0ltCwJyUTjeOE48vrrsnQb6mALf6zjVRtWYMFjbPkwrWmNM5chVCt0hjvU4QJTaevdahCZ4HsvlbXC7T70Zr+s0xwo0a0F5WqfI/MsrRL2hwdTI+AqAHD+dx3sB9tXv4IRrna2ZQjeeTuntJCpifq7V5DwGoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4EmLmnOXQthawcWUZFPpX+eaVtpKCLrmn/tiLmwbAg=;
 b=PYdlQroMuhY6PYNgClGIFkn6IGhYtJuSuvMXV5jq6JFUWAbVP4WkWv8J9Tg0ImgKwh56pATHijEx8xYOQiI0IE5X897dnKRdrUYuWJAEjtjidKE/nBihvpWq0xKAgmxCpkx21f0ivJ8j1W8qMyIlzQgNVfG9e7bJqI+NYGBot6hY/yU5KuK9rcmLnAP1YpPNFUJ9Cd9GZbgIZ2mVt1s8HxmjwH/+dLfMLKueLsynLTM3bCwVCbFsYabzD04T+bdUaRCkr/+edekva1unvQVDduRVooa0s6yDZF7sBddNJglt+KliTPg7GrMksM9Sz/scLwftGyV5LW6yml+WxYouVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4EmLmnOXQthawcWUZFPpX+eaVtpKCLrmn/tiLmwbAg=;
 b=fsKcpMNYb7+MXlSsJU2RztRGEg43CrHHgPJ6nGAIiQqWRCPrR5ydFjdP8PDDomtWuX4UcppdBYPjbAvZRh9p25l5J63Fne2r69OYCTK2Ec1hTtby8IhtkvlJtFtNL1W+xdVt1hkz1rIp9mt3mlsZsQHKWLOwl4h9Qm5pTxEfJEM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7907.namprd10.prod.outlook.com (2603:10b6:610:1ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 14:54:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 14:54:51 +0000
Date: Tue, 8 Apr 2025 23:54:44 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
Message-ID: <Z_U4tGL_tIUnMywo@harry>
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com>
 <Z_UwPmyxyu8YNLG_@harry>
 <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
X-ClientProxiedBy: SE2P216CA0037.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 797b7163-d49a-4b1e-6815-08dd76ad50a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3TQOFYfXQ64+4etw0Si+3Nh+0afzH4+ERF5vuMidyO1Zldr2IssX2AK4qT3e?=
 =?us-ascii?Q?Dd/wVqxCYtyg1i8Q0PMabpjQr5J2velSYrcpKEwHb+OnkHUK2uc6/gKvFrDR?=
 =?us-ascii?Q?6d/K3MXQvfkltJxMTR70DumdTuv4HcPhmxGpbNvkI7zA3WT15e9hGoSHb1YW?=
 =?us-ascii?Q?/DASofwS5EV9Iy+GOF8QQaK0+B8Mxkbl1kzK3ZvMXtTtXE0ZEAewjm8mV6Ki?=
 =?us-ascii?Q?PRuVrWUCaT3sSdY75cwpCxINjEQoRMFycbWI8EPNn/arX3KljgLKd5XXIEqv?=
 =?us-ascii?Q?6hlSHoD7Yk94tTxWbLsawfSu/ELS1yS54dVkvYKy+SXV7l+btYjvqPb4vqdZ?=
 =?us-ascii?Q?PWabDkeQdJPwX2duAvJq5vuflfA5iZguwtHju7U0+oXJ2vGo72jkrMo9x7jf?=
 =?us-ascii?Q?IsqyW7yq2jCrlPzuQYh9BOcxVR8vdrH8iQIh5I4CI1NR16tCe2xQ1EcRhmuz?=
 =?us-ascii?Q?SgOyMBR8tg7RI1H0yJDnsDxe7f+xrCbiIWbN1HXLpqZ6sB6MerzcruMSDmmB?=
 =?us-ascii?Q?H0TVfOhNQ/QGIy7s7b3J6ekvYpzpTM1LRkktC+ahx/joGVktjO8/Qpf/k42+?=
 =?us-ascii?Q?TF1AdALUqQKCC9ohTZ/1aYhpws70dwWegvYQLiUMuJKFflhckGzOCbPiZpKi?=
 =?us-ascii?Q?jffjjv+jw4ujLAJRoneyNn4LfOiAP+TZ+gIKrdbxZO/ZmygHdmpRvFMIgo/s?=
 =?us-ascii?Q?aTcWlL6XN/XR9WDNdnuIKftIT7QurhwRI/I7/UcXViZ5KFJ1xbOw+tFbfoVH?=
 =?us-ascii?Q?6Rov841hQIME0JLt7LHw0vTJutpiCwQPk55r4GNASOgUDxnrR6a0NU8gYJmf?=
 =?us-ascii?Q?pOLvEI4ggbOL5kvMBqHX/XqbsCZxkAHWTXB4FIyV/oKWz2Cw5U5DhGcA2V9K?=
 =?us-ascii?Q?DvFkzGkQZwg/SIfnbpim7f3oKrikR/jKL56GrIWa+g4tC7HUULx6GjKnJ3YH?=
 =?us-ascii?Q?Ov0fUCxqGeaSUGHHbBizFJ46nTJFVb9xHJiJlTbp3khZt84NVGzNfCit6GGp?=
 =?us-ascii?Q?xDqCasn6BYlmO+tNDLqiM6GeudgX4s9UM7cVRLS3epGa4P5tUAnSJS7MxYiv?=
 =?us-ascii?Q?FR6+SC7RndDokVUEvVRJ95J7YgZGz1rUTTJGdx8pyeS6fD2D53LSuxx+dGow?=
 =?us-ascii?Q?yl2wp+0sERlKYYyGT7KuKaIpp1oI/0PV4Ux2b1dHJUmnBfteOV7oTjVHO62B?=
 =?us-ascii?Q?O2S7yBUUabkDEB6W1Ey+3GgASgOrVgfgT2rbqIXVG+7Y99v5WG5AI1ZCPkwL?=
 =?us-ascii?Q?chHE1YDzysPHis6TyA7CIc5XDJ5phug7m29+mjDOfEKdAYh8EbRVCTxBDzd0?=
 =?us-ascii?Q?7LbKizLSP6xzHU74hmEYOA0QLmFf4sPGJ/BjRSyii32EpQ4e1jjJm3W+KtWZ?=
 =?us-ascii?Q?V9v+TBit1rpQvzc4P2gTunaflFL2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nYTGD1ihy3LLHQwC4Ya2v80chhG093neEhD9Q2ZXmpbEY6ATKSPmpsop8yc?=
 =?us-ascii?Q?2Y3pDLSS3o/SPoM5fBt2wwF0lyBt2T+4sf55rI7zoCQBUOQ7TRr6W0R46ski?=
 =?us-ascii?Q?G0xwgyOU+6q34tQLoOBKqxMCOeYv+hSRRolF7gf5iwido3eeWdzZpMXp+2UT?=
 =?us-ascii?Q?V/KnHKyehznoY+21lPAe7oD/xrSDA7FKdy2bOwkrvmU1nc9GMkFmihxWGuZ8?=
 =?us-ascii?Q?GYqo/H/gp4n3H0xOtMQbHCpBA+4eTx2Qgv68pR15w5NBzmhBR4JhJ52WnbX0?=
 =?us-ascii?Q?0f0qUwE8nNJ3JQEfxpLYVAdhT+asLNjX8z3GaqWC3M1Ap3hBjqW2szFubMcE?=
 =?us-ascii?Q?Ah+dNMrNPQiTqi5X72TtVWv6OqmD703BPBoyaJqTpLzIy6w3+5GFPEYdjvIQ?=
 =?us-ascii?Q?+7u5Y4QYE/Ij3AP03WnXRSr0n9QlS4OJoenhvEf+8sJh4ZAs6TqTmAFE2eHz?=
 =?us-ascii?Q?opV41GFRiKVsn7IAoti0BmYjCMR55TAzsU8eV/eShGT8s16Oad7hVa7u8rek?=
 =?us-ascii?Q?zXwoO1VzMDhNaTcdeNgLQR0hwg+JzUMIbnRUJSLSNRPQd+SQ87ybyFDZrAEY?=
 =?us-ascii?Q?ev0t6zbDqq1pDPOr57aXHaU7D4Ir1cS2Yk6hA5PHJxAEJ0MBpFyMA+/oWoN8?=
 =?us-ascii?Q?fcj2F1dlfmRkCvB9tzgcXPlOnOHFwL5Nm9z/epO6HO3z6Lsqqpj1A512Rcyc?=
 =?us-ascii?Q?0FI69jp1Xeg+FqxtNerM5HjhKK7XrsFwRLxGIOEkqa1TPCf3ZGS7tO07fD7Y?=
 =?us-ascii?Q?/8woX72Sw/guSdWKyxIDtEBjRjXoa1+NiC81lslq6BtyWloJcsruFJK1Wug/?=
 =?us-ascii?Q?EUPB/YdZD6vku7f6ls8QEGHuGkkXzGunprE5ZvR2FvfgjYnVHSGpsHMWKl4j?=
 =?us-ascii?Q?sIcBfNCIdwNHMuYFYhdukHP+H50JHqKrTJzZkAYYCIjvaK7N9ZlLRkcfWE5m?=
 =?us-ascii?Q?9lDv7z0yiPzlU9BXqw/vU1Gu6p0ym7DbAcp+FuuQKZcS/TMVLeKOJb1+sVfN?=
 =?us-ascii?Q?MD+Kr5z2b7hf/ka7NsIRyC42ejJ1lvx4NenTJOakrs6Wu4hB7/XSczXV5B1H?=
 =?us-ascii?Q?/NaE33Mt/59mlryjBxANpT8vioswIMgoivCnTRYLsWxPBlPp2+zPKgtpPLvz?=
 =?us-ascii?Q?U0GEcnXRXxthqd8+fzoIMo7MdKUwGLLzJq9341IH3bER8pI0yBjiswHU/mhH?=
 =?us-ascii?Q?XFT3P+xfgAxttSbD+JjZ1xjNrV8odBWIu2XjVbr0SI1GLLzHQcOQXtAph/rs?=
 =?us-ascii?Q?fkZAch8xR49tFSDgN4AmHmkvPrWeWO1V6bh96tAjbDwfLOS+2CG83mvLavf1?=
 =?us-ascii?Q?WG7dwDsijm29a1mESyYGtOIwR3IplsVsVbco2OQOGhEyUz0Gz8VQWyjNOhoN?=
 =?us-ascii?Q?DNuETUdnth92LM56Q2UJH0ZAvI5l7BohpOcZ74CCgFhE7V6UUQTsKaotHc/y?=
 =?us-ascii?Q?gIio1UqOUuM16RNOqsre8kqMwJfPwqmI5nWr4WnQARAZNBiQcmDaRmphYb8o?=
 =?us-ascii?Q?6IaGBxypShVkhvtu2fEBBuRG9uUuN+qArzSxQHk4aa1WIalJxJC5/cBycZcP?=
 =?us-ascii?Q?tm7XxqD3lkFzxrT75OmeJ4OaciHVZuAedyFWHV2U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PN3Ztt6L46rXlavoSxmRupl81lHWkIQEYuW2Wr4irUYKAAWTDu3TSngClg0IO+D+RxqMDnG40CXahN5dW6srBnhkivpCz4Ld3GPQ1EEQVYUHWp5gTm+s300N2+l35ot/34MRgxe1Xm67ZiRxfrOuir2SqSj24QvqpoBQJeImgDAlAVIOVyihapk1XQu2A9e4H7yn12vV5T7fy61G/fmYIV011UF51taTsDIBxTSEtSVVwUTem0mXtZc0fEvYzI77gSj48+5W3OGkyOzrv0LeIT+fDpUBvQ3C7jNEUOfUO9KJ53FY4d4bXiUWUQep4WSw3KhMmM54tQDqbnRVF8n7sM0dy3xx8TY8+ZZeD6PujsXpPbqWliswAvVMUKiwhXE85SBtmqTwZBEh8Pei/k5XV9bUiM+NIp+/Oi/Avc+OV6owYQGNCBPSQ/fgCUYWUYQdoPh+KCC8XB4Yf7riruNggyvmOhgZ7ziJivv8I9uyyd/VHM/7nX8x47O7Pa/yXWjePZ+YiCi4o7WeEk7k/nl1fslcMu9KIvFyw92pove85kE1hjiLHheu4TW7tSQ6P6sToMi/+lGFtWQaYKMem9eIR7O+riePuzEpcI5aFXkz9B4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797b7163-d49a-4b1e-6815-08dd76ad50a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:54:51.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Pyi3SW5hWl+qiJVzN5WGkm+6mIRNA6Iv4zKzYXwfaiHAIx7ZU8P4zSp05/hCVPCy0w7QEZR5YG7bXN4K96YDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080105
X-Proofpoint-ORIG-GUID: oLEydQKz-jPvNFhqjf3VAZZhIWMdK_EA
X-Proofpoint-GUID: oLEydQKz-jPvNFhqjf3VAZZhIWMdK_EA

On Tue, Apr 08, 2025 at 04:25:33PM +0200, David Hildenbrand wrote:
> On 08.04.25 16:18, Harry Yoo wrote:
> > On Tue, Apr 08, 2025 at 12:17:52PM +0200, David Hildenbrand wrote:
> > > On 08.04.25 10:41, Oscar Salvador wrote:
> > > > Currently, slab_mem_going_going_callback() checks whether the node has
> > > > N_NORMAL memory in order to be set in slab_nodes.
> > > > While it is true that gettind rid of that enforcing would mean
> > > > ending up with movables nodes in slab_nodes, the memory waste that comes
> > > > with that is negligible.
> > > > 
> > > > So stop checking for status_change_nid_normal and just use status_change_nid
> > > > instead which works for both types of memory.
> > > > 
> > > > Also, once we allocate the kmem_cache_node cache  for the node in
> > > > slab_mem_online_callback(), we never deallocate it in
> > > > slab_mem_off_callback() when the node goes memoryless, so we can just
> > > > get rid of it.
> > > > 
> > > > The only side effect is that we will stop clearing the node from slab_nodes.
> > > > 
> > > 
> > > Feel free to add a Suggested-by: if you think it applies.
> > > 
> > > 
> > > Do we have to take care of the N_NORMAL_MEMORY check in kmem_cache_init() ? Likely it
> > > would have to be a N_MEMORY check.
> > > 
> > > 
> > > But, I was wondering if we could get rid of the "slab_nodes" thingy as a first step?
> > 
> > The following commit says that SLUB has slab_nodes thingy for a reason...
> > kmem_cache_node might not be ready yet even when N_NORMAL_MEMORY check
> > says it now has normal memory.
> 
> node_states_set_node() is called from memory hotplug code after
> MEM_GOING_ONLINE and after online_pages_range().
> 
> Pages might be isolated at that point, but node_states_set_node() is set
> only after the memory notifier (MEM_GOING_ONLINE) was triggered.

Oh right, didn't realize that. Thanks.

> So I don't immediately see the problem assuming that we never free the
> structures.
> 
> But yeah, this is what I raised below: "Not sure if there are any races to
> consider" :)

At least on the slab side I don't see any races that need to be
addressed. Hopefully I didn't overlook anything :)

> > @Vlastimil maybe a dumb question but why not check s->node[nid]
> > instead of having slab_nodes bitmask?
> > 
> > commit 7e1fa93deff44677a94dfc323ff629bbf5cf9360
> > Author: Vlastimil Babka <vbabka@suse.cz>
> > Date:   Wed Feb 24 12:01:12 2021 -0800
> > 
> >      mm, slab, slub: stop taking memory hotplug lock
> >      Since commit 03afc0e25f7f ("slab: get_online_mems for
> >      kmem_cache_{create,destroy,shrink}") we are taking memory hotplug lock for
> >      SLAB and SLUB when creating, destroying or shrinking a cache.  It is quite
> >      a heavy lock and it's best to avoid it if possible, as we had several
> >      issues with lockdep complaining about ordering in the past, see e.g.
> >      e4f8e513c3d3 ("mm/slub: fix a deadlock in show_slab_objects()").
> >      The problem scenario in 03afc0e25f7f (solved by the memory hotplug lock)
> >      can be summarized as follows: while there's slab_mutex synchronizing new
> >      kmem cache creation and SLUB's MEM_GOING_ONLINE callback
> >      slab_mem_going_online_callback(), we may miss creation of kmem_cache_node
> >      for the hotplugged node in the new kmem cache, because the hotplug
> >      callback doesn't yet see the new cache, and cache creation in
> >      init_kmem_cache_nodes() only inits kmem_cache_node for nodes in the
> >      N_NORMAL_MEMORY nodemask, which however may not yet include the new node,
> >      as that happens only later after the MEM_GOING_ONLINE callback.
> >      Instead of using get/put_online_mems(), the problem can be solved by SLUB
> >      maintaining its own nodemask of nodes for which it has allocated the
> >      per-node kmem_cache_node structures.  This nodemask would generally mirror
> >      the N_NORMAL_MEMORY nodemask, but would be updated only in under SLUB's
> >      control in its memory hotplug callbacks under the slab_mutex.  This patch
> >      adds such nodemask and its handling.
> >      Commit 03afc0e25f7f mentiones "issues like [the one above]", but there
> >      don't appear to be further issues.  All the paths (shared for SLAB and
> >      SLUB) taking the memory hotplug locks are also taking the slab_mutex,
> >      except kmem_cache_shrink() where 03afc0e25f7f replaced slab_mutex with
> >      get/put_online_mems().
> >      We however cannot simply restore slab_mutex in kmem_cache_shrink(), as
> >      SLUB can enters the function from a write to sysfs 'shrink' file, thus
> >      holding kernfs lock, and in kmem_cache_create() the kernfs lock is nested
> >      within slab_mutex.  But on closer inspection we don't actually need to
> >      protect kmem_cache_shrink() from hotplug callbacks: While SLUB's
> >      __kmem_cache_shrink() does for_each_kmem_cache_node(), missing a new node
> >      added in parallel hotplug is not fatal, and parallel hotremove does not
> >      free kmem_cache_node's anymore after the previous patch, so use-after free
> >      cannot happen.  The per-node shrinking itself is protected by
> >      n->list_lock.  Same is true for SLAB, and SLOB is no-op.
> >      SLAB also doesn't need the memory hotplug locking, which it only gained by
> >      03afc0e25f7f through the shared paths in slab_common.c.  Its memory
> >      hotplug callbacks are also protected by slab_mutex against races with
> >      these paths.  The problem of SLUB relying on N_NORMAL_MEMORY doesn't apply
> >      to SLAB, as its setup_kmem_cache_nodes relies on N_ONLINE, and the new
> >      node is already set there during the MEM_GOING_ONLINE callback, so no
> >      special care is needed for SLAB.
> >      As such, this patch removes all get/put_online_mems() usage by the slab
> >      subsystem.
> >      Link: https://lkml.kernel.org/r/20210113131634.3671-3-vbabka@suse.cz
> >      Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >      Cc: Christoph Lameter <cl@linux.com>
> >      Cc: David Hildenbrand <david@redhat.com>
> >      Cc: David Rientjes <rientjes@google.com>
> >      Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >      Cc: Michal Hocko <mhocko@kernel.org>
> >      Cc: Pekka Enberg <penberg@kernel.org>
> >      Cc: Qian Cai <cai@redhat.com>
> >      Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> >      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >      Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > 
> > > 
> > >  From 518a2b83a9c5bd85d74ddabbc36ce5d181a88ed6 Mon Sep 17 00:00:00 2001
> > > From: David Hildenbrand <david@redhat.com>
> > > Date: Tue, 8 Apr 2025 12:16:13 +0200
> > > Subject: [PATCH] tmp
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   mm/slub.c | 56 ++++---------------------------------------------------
> > >   1 file changed, 4 insertions(+), 52 deletions(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index b46f87662e71d..afe31149e7f4e 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -445,14 +445,6 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
> > >   	for (__node = 0; __node < nr_node_ids; __node++) \
> > >   		 if ((__n = get_node(__s, __node)))
> > > -/*
> > > - * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
> > > - * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
> > > - * differ during memory hotplug/hotremove operations.
> > > - * Protected by slab_mutex.
> > > - */
> > > -static nodemask_t slab_nodes;
> > > -
> > >   #ifndef CONFIG_SLUB_TINY
> > >   /*
> > >    * Workqueue used for flush_cpu_slab().
> > > @@ -3706,10 +3698,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >   	if (!slab) {
> > >   		/*
> > >   		 * if the node is not online or has no normal memory, just
> > > -		 * ignore the node constraint
> > > +		 * ignore the node constraint.
> > >   		 */
> > > -		if (unlikely(node != NUMA_NO_NODE &&
> > > -			     !node_isset(node, slab_nodes)))
> > > +		if (unlikely(node != NUMA_NO_NODE && !node_state(node, N_NORMAL_MEMORY)))
> > >   			node = NUMA_NO_NODE;
> > >   		goto new_slab;
> > >   	}
> > > @@ -3719,7 +3710,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >   		 * same as above but node_match() being false already
> > >   		 * implies node != NUMA_NO_NODE
> > >   		 */
> > > -		if (!node_isset(node, slab_nodes)) {
> > > +		if (!node_state(node, N_NORMAL_MEMORY)) {
> > >   			node = NUMA_NO_NODE;
> > >   		} else {
> > >   			stat(s, ALLOC_NODE_MISMATCH);
> > > @@ -5623,7 +5614,7 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
> > >   {
> > >   	int node;
> > > -	for_each_node_mask(node, slab_nodes) {
> > > +	for_each_node_state(node, N_NORMAL_MEMORY) {
> > >   		struct kmem_cache_node *n;
> > >   		if (slab_state == DOWN) {
> > > @@ -6164,30 +6155,6 @@ static int slab_mem_going_offline_callback(void *arg)
> > >   	return 0;
> > >   }
> > > -static void slab_mem_offline_callback(void *arg)
> > > -{
> > > -	struct memory_notify *marg = arg;
> > > -	int offline_node;
> > > -
> > > -	offline_node = marg->status_change_nid_normal;
> > > -
> > > -	/*
> > > -	 * If the node still has available memory. we need kmem_cache_node
> > > -	 * for it yet.
> > > -	 */
> > > -	if (offline_node < 0)
> > > -		return;
> > > -
> > > -	mutex_lock(&slab_mutex);
> > > -	node_clear(offline_node, slab_nodes);
> > > -	/*
> > > -	 * We no longer free kmem_cache_node structures here, as it would be
> > > -	 * racy with all get_node() users, and infeasible to protect them with
> > > -	 * slab_mutex.
> > > -	 */
> > > -	mutex_unlock(&slab_mutex);
> > > -}
> > > -
> > >   static int slab_mem_going_online_callback(void *arg)
> > >   {
> > >   	struct kmem_cache_node *n;
> > > @@ -6229,11 +6196,6 @@ static int slab_mem_going_online_callback(void *arg)
> > >   		init_kmem_cache_node(n);
> > >   		s->node[nid] = n;
> > >   	}
> > > -	/*
> > > -	 * Any cache created after this point will also have kmem_cache_node
> > > -	 * initialized for the new node.
> > > -	 */
> > > -	node_set(nid, slab_nodes);
> > >   out:
> > >   	mutex_unlock(&slab_mutex);
> > >   	return ret;
> > > @@ -6253,8 +6215,6 @@ static int slab_memory_callback(struct notifier_block *self,
> > >   		break;
> > >   	case MEM_OFFLINE:
> > >   	case MEM_CANCEL_ONLINE:
> > > -		slab_mem_offline_callback(arg);
> > > -		break;
> > >   	case MEM_ONLINE:
> > >   	case MEM_CANCEL_OFFLINE:
> > >   		break;
> > > @@ -6309,7 +6269,6 @@ void __init kmem_cache_init(void)
> > >   {
> > >   	static __initdata struct kmem_cache boot_kmem_cache,
> > >   		boot_kmem_cache_node;
> > > -	int node;
> > >   	if (debug_guardpage_minorder())
> > >   		slub_max_order = 0;
> > > @@ -6321,13 +6280,6 @@ void __init kmem_cache_init(void)
> > >   	kmem_cache_node = &boot_kmem_cache_node;
> > >   	kmem_cache = &boot_kmem_cache;
> > > -	/*
> > > -	 * Initialize the nodemask for which we will allocate per node
> > > -	 * structures. Here we don't need taking slab_mutex yet.
> > > -	 */
> > > -	for_each_node_state(node, N_NORMAL_MEMORY)
> > > -		node_set(node, slab_nodes);
> > > -
> > >   	create_boot_cache(kmem_cache_node, "kmem_cache_node",
> > >   			sizeof(struct kmem_cache_node),
> > >   			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
> > > -- 
> > > 2.48.1
> > > 
> > > 
> > > Not sure if there are any races to consider ... just an idea.
> > > 
> > > -- 
> > > Cheers,
> > > 
> > > David / dhildenb
> > > 
> > 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

-- 
Cheers,
Harry (Hyeonggon is my Korean name)
