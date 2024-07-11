Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AF1EEF8;
	Thu, 11 Jul 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724599; cv=fail; b=Wfy9tPrO6efeRa/LqHx5cRUrplxIbp+2+7fSSOWg29dYYt78vVrGOiJYBgAteUdnWVap/sCN97tJtkKIEjP96/O49l3pJx39qxNIA8nnBcmnuYJn0ykNcUhcnRidbntyMMG4+Q47hfY87xPKcw3kZw9JlZuP3JCUvOTk0OZFoyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724599; c=relaxed/simple;
	bh=PP0QpSUjQ0ucU9X39AbY6e/iJM6QZd4jNHodCxYEiPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SnqMIn4HAsEWj/7x+nP09KnOPS3D8PKLx5Mmueal+93vmX/JKLPIwQPALQXTfH/i6QDuW3bJcjZcb4hccQL9tGhPgFeYsl2NLAq4Cz3a1mmBlDcMkEqa1zkOaLM7dgtvIkHxuKh3RPlj9e6NClJGrb+bkKl7CQLukGt3VLngaLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xGlubG/7; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xGlubG/7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6PxP+faxL8o8FLio2pAEK5m2gVJrPngbPLMqj8YSj7x2MJ7v3HoZd2XLKezM6zDF082qp38/IXuHz3+WveTc2bpb9QfjuF7NzgLMPIbn/YUpp/NS59IbeJK8u2d63yVqNlkgq9CnvZ7+fp32eWnK4XwoQpwG1+im+ZTcZJBku1sYB5jQb3YzNJutzwHifSeTDCzWYCrdvEhDtQvJEIW4q2Eyg8R4lpbUO08JK65lhEyI3LJm7h8IxW1RhnG5viJy0WA3l0SNZJPLr3nhleDkIvWSSm7eVZnBt4TumceI2ehghCzZTdymr6houWHRg94qLpr6WliUHDND1yIh2JjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkhurIWMcBIodzm7+8IKNLbMzrsV9b56DLzsusFAmEQ=;
 b=Z1dFyEl5WS4iTqjpQAcVklsJUPmOcHVRlr3STKOi2PmK6mZK2piK4sixiQr4tTDqxHlvsxzzON/JGodUQeCUuYhArKUwpQ9898dtEmth7/S1Ums75knw9fHIGJ4fS9pGpBHXweaBvcOcXT/bT3x8B6RIOwzE5QVnV3b/OtbO21fAfD77SMEad/W8k/wGZt+JQfu60sYWjgyOy7Jr21zHglXK4X7rqIYMktZXYqkMrySXgfNRRi8qqinIYl7K3B6ZT8GJiL6EFbNrUIhA6U+c+HKpx9v266JjJ42LaUSIlSG/IRVg5ddmzf/daZe1iY/d+716D95cg+5Z9CbfQxvNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkhurIWMcBIodzm7+8IKNLbMzrsV9b56DLzsusFAmEQ=;
 b=xGlubG/7HiSef4UU6d47T7Y1eaVpdF/m6rhVXMLbVQp5tqqo9sZzG9592WiKzhy3dmWQ30WwUpqydjxdcg53P+3MnfPWob1LuJLJHOw3gRHxQTc41VoYBxIQRNbJHu8C2SNiNgWjsbRhHfraM1AXZfiaUwtQfyODWraXp1WzFQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 19:03:13 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 19:03:13 +0000
Date: Thu, 11 Jul 2024 21:03:09 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Address translation for HDM decoding
Message-ID: <ZpAsbceUL-D7YJSR@rric.localdomain>
References: <20240701174754.967954-1-rrichter@amd.com>
 <Zo8hJm7y9VIwhiDk@aschofie-mobl2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo8hJm7y9VIwhiDk@aschofie-mobl2>
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: cb60a9e7-9310-43eb-aac8-08dca1dc1cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WX8HjMFzloZYofslcO3Q9ORfOTx0TAnDjjCCl7c1T0jpFUft27U+pzjw6JMB?=
 =?us-ascii?Q?Rsl+LwCsvaYgvQvXZuIsSjszJXesBHKeWtSCwJjmU0Z5rtqG8w2tBqXnZvFc?=
 =?us-ascii?Q?WGnogd/UZ8kqCkvvWhFzWmfs1aM9gETEKJx0PTxSHsCy2cfecMW1UTpCxFxI?=
 =?us-ascii?Q?8Uc1vqtyK8x/kRbqLCjBoi/n7AJFQIvGFWpWacVioD3x3p+5doz6as3KLok4?=
 =?us-ascii?Q?7HrzwESc86HssqWuD8mKP7xv+ZfjNv+OHWmOR0x++qMjk1Fy8oDComLZvVd2?=
 =?us-ascii?Q?HXLtfp1pyqDXyVBkzOwE3GayqyWtT19+y7I+U6iRen5DtluxwsOYjAhaPlMh?=
 =?us-ascii?Q?6KYu8JMCEUw0bqlxHl5gBj7BEQeQXKnBhMHbriX1peAJoN85h2364+njL9PY?=
 =?us-ascii?Q?W9Pe0EP5v2i07FihpWjNv4uHFfa7jnMjnLAUzfp3cSfuQUCobqhC1Oxjun9S?=
 =?us-ascii?Q?dD/HZ/kj8Dkr3w/KA38HEPwkstAKAdIvjfs1BHY6ptYZQI6SMc+4ixC0QYiA?=
 =?us-ascii?Q?gkUcEuCsdRaiBa/qvdQTxb0adSz8/fVL/kRSY+ZUhpPrqDgxZOzXjcWElMoS?=
 =?us-ascii?Q?1rBPAU6f9U5INE234UnkvkqbJ+WbZJAa/mvpaVu+/jHqbQo9+j/SLboj1aLL?=
 =?us-ascii?Q?fnkDBSh4EqGppawFsNSXKyb3eV8iw58+v6pA7NdVS+OREija0dBLBOm1Xnvi?=
 =?us-ascii?Q?LlFh/yABUlDgTWiIfOJnZW/FU0+14K2kFqcqkY+o360IVyDk7qxof0xZGY/e?=
 =?us-ascii?Q?+B30BVBOm07Bfu5QZUUlQiVqbcBXEMVSRHBmvgxnMXZmrg5qNhqWz/UZTxCO?=
 =?us-ascii?Q?MTCCSFm9C4bBAfGt5eOsmHyMb+X8FAf2nomwttMfYqLend86XPCetUDWPCc3?=
 =?us-ascii?Q?4kLye9v0MoDclMGga2wRYW0NHwx+Ve++5A81EzpyItuZ/hQDdi0N33LuRHPp?=
 =?us-ascii?Q?gvExHIXYQAleC81OABkiPxoHIkJUqnwplEuHgVILcxsBQ6KquZHE+ife0SPe?=
 =?us-ascii?Q?1k/Da5M96XRKCvy+yPON/IIeJBZHqxTDDywIvly4HrZfzTbPC697v5pbj4A5?=
 =?us-ascii?Q?h4e+LF5vjUpxu5JBlHaXSjnhADdFV6VkI7UBxhZceI5hA9JLDXpF8oz7xb9e?=
 =?us-ascii?Q?yiQGIUR/xQFZ7pPIhJUKJUWVXHaiWNKW6TqLR/AKWj3xwpCUQqxbc+u8XLb8?=
 =?us-ascii?Q?14vWyjjX4VA8ipeuVi1cHsNGAxtacNNCIQXPjcrdKhf9UmIsWyX0qxBy7c2u?=
 =?us-ascii?Q?WI++lUsmnmVn0INah7wCKCHTwZg3bdLQ1+1cfT1OCnJgLmAkB/51OrAKEyO0?=
 =?us-ascii?Q?Nyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ojGBHuYHIYFoO5a/0ERIcO8Lv4c2cmaGMvnN3JX2gpNQWu8Tl9w+mCg5vNnE?=
 =?us-ascii?Q?DE6FK5XbffavZ7pzSxDu/T/gzKeSMgMXNefucIGbN0x9ySyklc2D7flR99eK?=
 =?us-ascii?Q?8kxHnvJLufGf0TdfK0yLOHkZaZORZsKin+TgS9e7s8YJjED2xGUHy5jp3rnn?=
 =?us-ascii?Q?gJcnSDRIEEvBryVi7MtISazgitDmLwEFqna6YguLj0VKKJI7aE1eMLaCWOjU?=
 =?us-ascii?Q?SclUBoUK50io38exCCfK75GhWMIOYrvnt5Zer/kc1FdJgNCbDHCxQ50k5XDh?=
 =?us-ascii?Q?ussKk/tvHuX8dzn8uJWdVRUvTlIbPVQG4jbehYljcUVRQbvo7ACW+Jr9VhWR?=
 =?us-ascii?Q?Y4JRJO/sqqK4/D4HmQA/7UuRY9BG4t7VcP1DE+Oj+3NB7PfSd5CBhue24xY+?=
 =?us-ascii?Q?wAxjRHQc9smenBKbK7p19L9sZREImem6sEzWCxOP4/rYXy1aP9dMidmJnTWQ?=
 =?us-ascii?Q?I5BGfuRwVyBgu6GYZeiUUCFxrnRx0zaqOCgAh1ACxi4OfDJJlDHl/XBCq3TP?=
 =?us-ascii?Q?qdGOose9HkOO7jmt+gpxDaC1VJenDH/s1R95SqJ1q67fLPep/X0KFndDNZok?=
 =?us-ascii?Q?JgjqT/LMWFvhz/gqMK/KreP8/Ok16nAhJ7F1OBDZetWV3ad7+0dAl24DNrsC?=
 =?us-ascii?Q?sipQ8FahxBeM2oVOLFThBgP9/O0GUK7qVppGUN8pRwQFOnoawi3zEYwNuYiv?=
 =?us-ascii?Q?ylRF+8vN8kjdNLOZd1uFaDRm+WPWOfbKGjvS3rl8Hfm4w2fh8JjfJHtbhxQD?=
 =?us-ascii?Q?Th/V0ENmPy/dBYtHvBjngdWd+XHOvS1NMk5Xa9HO75Gq01lCanmYqP+9O/V1?=
 =?us-ascii?Q?ZVSY4vFAmqWFZb15YGWDsgc7Nfl0s6Qo1lI0Yjvbj2cp3lgsOvATD9enLHU5?=
 =?us-ascii?Q?+abWerMl0vHtzsGo9tnIfcFsmv3UrvxTN7PCrsuVC8JdPPgZHIAXDIQpMuIL?=
 =?us-ascii?Q?tnuF7G5KKzFsIybdkrFuq/xdEc8Zruwt/hcXzLwx7EOC8x61TyiblfQPS4l2?=
 =?us-ascii?Q?y3SnSBsvKd1yzmHQ5MkwIsoybeaelcac5tYFQ12CbqZroI8wCNozE/yH5Azb?=
 =?us-ascii?Q?cA8BTtil47wD9YIFaV/zx6eqXceFDJ66pxsCSXzQfI/cY/eTVgfdKjX4c3aE?=
 =?us-ascii?Q?boRUFkDVQqRe456kYoFP5ClXBcrSp0ce6m1SXiwGrUAW9clrhUpBnzjIgmJZ?=
 =?us-ascii?Q?3qHuChs3t9ShnycKlRdnIfuwLZor8VBCZ8HG6/kkrbpvCn+QiA21saykKeXK?=
 =?us-ascii?Q?6GcHbUm38516lqcIBbEQExOiozsjvz4YonFrjGn1h9JRkIDB3u59tAQu/MwX?=
 =?us-ascii?Q?xWM/hJLWAja+V5HVcqXfQ7pualbKb5BcphFD+ceBwHa3c3OziEW1AukE50/U?=
 =?us-ascii?Q?sWf2cxDTXFH9yc8j04vxBEYaSR11sDijDoixICJiZ24RpXvhLgiRAxLFSVSA?=
 =?us-ascii?Q?33MrmmHsFXBZHZ7B64QS+VotJ1dXaW6P+XQxVO+ay9osD1Ll9S3CPtxy4wdx?=
 =?us-ascii?Q?nW9utBoeME2Z2X7ceCww4GD7ju24ZOj8LF0XzTgAwrV7g70iGMJt1BY8tKhR?=
 =?us-ascii?Q?UNZtSmc4Buz+LZB2/KrgxkRypyq67dGMQWMR6xjx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb60a9e7-9310-43eb-aac8-08dca1dc1cda
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 19:03:13.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /onBRkLCFKBLjnlehUshIYXR1dAVM79jsEZ6DJnSr1ExtHXgGsY0d84bftOf7fkQdI64nANyIBPBxTRAzeirfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

Alison,

On 10.07.24 17:02:46, Alison Schofield wrote:
> This HPA->SPA work needs to be done for addresses reported directly by
> devices, ie DPAs in poison and other events - right?

we need it to translate the base address of the HDM decoder cap
registers or the range registers to an HPA when accessing it.

> For the XOR case, we discover the need for HPA->SPA while parsing the
> CFMWS and add a cxl_hpa_to_spa_fn to the struct cxl_root_decoder. Later,

As some platforms allow an even more fine grained HPA/SPA mapping that
may devide a memory domain in separate SPA ranges we might just want
to move it directly into struct cxl_decoder so that endpoints or
switches can use it too.

> when the driver wants to translate a DPA (to include in a TRACE_EVENT)
> it uses that 'extra mile' HPA->SPA function.
> 
> See Patch 2 in this series:
> https://lore.kernel.org/cover.1719980933.git.alison.schofield@intel.com/T/#m9206e1f872ef252dbb54ce7f0365f0b267179fda
> 
> It seems the Zen4 extra mile is a simple offset from the base calc.
> Do you think a zen4 hpa->spa function will fit in with what I've done?

Thanks for the pointer, I will take look into the details here and try
to reuse most of that infrastructure.

> 
> FWIW I took this code for a spin through cxl-test on it's own and combined
> w the xor address tranlation patch set and no collisions, all humming along
> nicely (for non-zen config).

Thanks,

-Robert
