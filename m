Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E96223DF0
	for <linux-cxl@vger.kernel.org>; Mon, 15 Sep 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929386; cv=fail; b=F7B0onoeJoDKBugAB/+1oRO1WJE5PVHgKOZLbOc66vt6b+iIvLnblbrqH1GYJhrp/ZAfIReeu6DFJa/OWPgKAW95Gihg2P4rhVUy5wuIYcvW27FLRuOmKkkB1MIBaynRKW/WVbN4DH8ecBYe6Uint+iMZXa86Mx8HGJFT91nVtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929386; c=relaxed/simple;
	bh=3cUJ2ENQ7OXRBIzHmaCY85C+FloR/NlVy6ikBJnPbyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nuw7hfr+jIbCSzzcjPzVrzfzuQnomZeIoazdQzRQjEsjN8+mhDVySwUrzUKomRn6qEJeFGXQhxGs7CN8ThMIfAMDMNyYYyBV9ks/peFHs1acug1Dih1AauTr3O0lZk/zFq2+fpbC89ZT8c0cCJ+pxNoIFqWy6AgD+mrD1EY6/J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q1xBbwLS; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q1xBbwLS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpO+4FviCwsxUOHbbUY4YBV4BTKE1Oz1uCsAkKEHq3qqlMuJ+wLUVclK8HLH9vbbGJ6hTeF4F5jHs1XWgsSEhxcoxuPyNHtlxJP+xIcIVSAJP5GOhVCzmu9qeCFp63CdJGRCy8uVResyU7n0ZeJPCuawc+pIkCyLMmi53kQNgdyC2fO1yasif7bJ57cto0fdudoY272d+OYf1oL3dxt/DZqRNyN+QoSSvH6m/xKAk3isuskiHDa5bmEiCXBbWuyVZexcxlS1Vr2DG0Jtc8YWXmvhn/97nktbVNecMTJF/AmMDuJR6D/EEGtNupFof2kAi2mqrnFCzLCkQOhPFP45Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kbe0UVgjggFFHJByelEQO3QhvcVOBgij9rYg+uyluI=;
 b=gMLY5ZeGJ5ld2z5eoLETjQTNTQgdxv/Nr5toBWIhRa5gjrl6QaqgAK0RfXbDxl3KtUK6PpB3WQeyG78olVk9ZyEUQgqeipODENZmkZcR0x3tL/kcKDLGqS96HyTERpph2iB33h2o4yWfTZ4ippRmJave3EZE8Mu7ztVwETgMW7z1SJjK2NZqx3PQK8gRdoo2Ieiu2fP42FPqGgmWvXMlrqiqFIovIVSsYSnmJKEtnJjAg7kzA+gVCkL3YkOE1rqMQzvgBTo+3G1vwUDxphN7w+Cg2M5TJqO9TXojVc5+6Ybzmaow1iK/U3Kpj5+Ds+u2P7+v2ug//Maf/c8lOq9fRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kbe0UVgjggFFHJByelEQO3QhvcVOBgij9rYg+uyluI=;
 b=Q1xBbwLSJVNo9jxrtS10fZADm0d8Y7ALlONzhiSB3WfYpI/MjYsZ7tHtr+yjeM2t3Uonlms+1I+EJIA64lg2sp3PFld/KDwVEjEXJn9meR4J9+MUtbqw6NzRAiVYZIAkwDLfs51FycFOi6UQW7IU0B1eL/Co0zIIYjFU7LIXASo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 09:43:01 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 09:43:01 +0000
Date: Mon, 15 Sep 2025 11:42:55 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v9 02/10] cxl: Add helper to reap dport
Message-ID: <aMffn3KccSkx6MBF@rric.localdomain>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-3-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: c58a2102-8924-486e-1c8d-08ddf43c427e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XxCXjAiMCRWze+yT7booZk/fBcXLvQuhMIGoMmEq7k6pNJXpNXR3bB7KuXfr?=
 =?us-ascii?Q?noFbKCIkBhNJYJYlqFfpo1Cj57LJK/UIQzs88ZLwTbiX/CJtGyoU4bJ8wp8s?=
 =?us-ascii?Q?oGqFUTzn7JpdqJ2BkvF61OC9R19uh3kDdl7KDkxsamEqMUvXg4ugJNz237zy?=
 =?us-ascii?Q?z8Bcy1Cyt2IrHpNFACXWUonIWaxHy2/UeSd6GM7PeekAREXg+q3/qM2Y7ZDr?=
 =?us-ascii?Q?qZ066AlNb2R+SUYpaVuHlOT82DrzK6qXq8MWXntAuaq+GFE+SP7r4DQFUjkN?=
 =?us-ascii?Q?tlGByje1kGoOUis2YV/kel8BOiXQm0c8K3ap4opxqnpQw7Rs0o/hvMgp6cz+?=
 =?us-ascii?Q?H/bf5S2ZrMktciOHjZ+Qv+b0j3OB2+bo334XuBkJ9qVro3QtxVT3cDh5vrWO?=
 =?us-ascii?Q?7mNVVw32TpJH6Oz0lyq5I5dVMtR0ypNzmLTlGbrSSGUZ0aZznbwedIg5IRm/?=
 =?us-ascii?Q?Z37Mgulgt72HIF2mTEBzqgCXCb/wOqG8bTEoetda4s5qyxy1Ogife41eGkSB?=
 =?us-ascii?Q?BGGX95jjHcxWvYdixIHdn4+uPdL2AzC8zJpUng1bdOOvu54mb1gE6u+PIsJm?=
 =?us-ascii?Q?e95lFc8YKDAcKNC6DLJzu792TGWDBWUownqq8KVb1GlRZbJn2tvEpQbU07Jr?=
 =?us-ascii?Q?4IS2lAXztbzQktamQG/SIQ3dX4h5qaQWyrYECZWrCsvZJGQh+n0xYbVgUXjM?=
 =?us-ascii?Q?oQHxtsiBC8RYiPai9w6UUT3vvs/+g0GabgBkRGn5wfOAJcDLfAFxBif5ru+8?=
 =?us-ascii?Q?+3Ii7oP+x3x9GtbTI5zSYHVOH1KA/d9NfL6yJCQJeGEjW5ZyQXCfdQY7SyNG?=
 =?us-ascii?Q?ZXSH0uQNLVg8dgB13qdiQHD/vguo5cVMB3p6eI1LhEBqcCsns8vT4KeFtyq9?=
 =?us-ascii?Q?jNdNYEcFUup9SVHovueYiRal+KulERzW1hcOzp88XjSaqlv8Bgs6vioPPVPN?=
 =?us-ascii?Q?m6YXpwgerFNc3Awv9GSLljZ/YbZME/QioxHGSlhWABc7OsnP5y00jCgs1P39?=
 =?us-ascii?Q?n519Iq9y3LRncFMxnOh3LC9nQBQFoO7hjirckaSRA/jFiLBhb5SPWiQopNcq?=
 =?us-ascii?Q?8p+DqolbhhUTdKmvTFCAYtP+xTGOG3g7+hhPZvFTGp5ldYECw3S75wo5WHGj?=
 =?us-ascii?Q?Bxnrhp1Qn0nrbOs/+OJxugE1fRmc0WRcVtDSytt/+9W85pvwNbc4T8BfbDbx?=
 =?us-ascii?Q?HScrGFEmkb/EEe5deTwlRmHzNsgnajDJgBDsGJj97M74XpoP67jAfwe06xqv?=
 =?us-ascii?Q?SbfZx0escoqX7UE8G4smn4e0Mk17QH+mMpdd+xN+mLLCndz2buGYQmk2X2sn?=
 =?us-ascii?Q?MKHYnw6WAfEAv7Vph/eR+SNh9hHJ2buKjS0vxCDuiEkT2gXWNyAeOrtXx4Lx?=
 =?us-ascii?Q?5m5O8y6h6WbYWXdInVNQdkWzMRSDLhOfzXoBT+TgK+keoSxnDehNxxa83O6G?=
 =?us-ascii?Q?/Cp+jhjXp+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XkvlTQJ0wbIQfqGZH9yoPYWjhJhs/SoevZDPwdwgNqdfHdyFg2yhatzQA31/?=
 =?us-ascii?Q?cBuFcsMp0lk+47tLTP184mSAp6T1FLgtRjvTI+cl8w5AAQvRVsWD6nvVoxrO?=
 =?us-ascii?Q?lIsQOVATtAocf0Qtznu5WcBUBlRLe4f7OJNDa93OBmWmkNDuJv0aZaSp6QQr?=
 =?us-ascii?Q?kx5zKGaSHNYfBZwMXdHDKDswpB+yuRrdv9eavGqiLXbLxfGwtj7qetHKWmpY?=
 =?us-ascii?Q?IELu/MQ40AH9n5jxJtO+xvR0AnQiIukhV5be0P84UJV8wb6/mCBpXKlGXqjD?=
 =?us-ascii?Q?ZdE/aXTVY8MYd4wCWw/+bH2+gX10XPIn0bg+IFDwajr1S9ZivDUmNpVE3Gn0?=
 =?us-ascii?Q?9Hh1EIo8cTqpLGdIUvOs8ReCUJ/QvlFljEFCruZS9tjgsw29/wGAGvH98Ttc?=
 =?us-ascii?Q?1ZP4JvAuqTCSgVe4DcjpCaprFUESptnS7E76PNnqzbGD8jNzBa/yLtSh1D9m?=
 =?us-ascii?Q?QaGVqeh/kkg4nR5sWP5mTw9PxqPafjmR4FRFgtzzxeksQTC8pF0SC0YSEGIj?=
 =?us-ascii?Q?CobHJ4pOCfVaabxf7dHZvpJG/NvLw6y/EKlCbUAIq7DgVYFsCDMfmcBC6ePU?=
 =?us-ascii?Q?VppzoyjaZSRNgrQ7UdP5mXVcsja/TLq2jqaRS/Kae+jodPH1hJiCZH5kNg3p?=
 =?us-ascii?Q?fE5LINamdFHmJVxvEGikAI2PurN42dfshTQI5v9f1xMHIwNIdJKtaFBxmmX+?=
 =?us-ascii?Q?haZc0aYxyDviOEQhihqqNJDEbvYw26sdR9XD2e3dtNSckDU+8q1ECMzzH6d+?=
 =?us-ascii?Q?VABKpdgySSymdeDhVTSdlnuPoX9/tJih/ZKRfl4N8tHwVeFpsomv0BIwfWFZ?=
 =?us-ascii?Q?08v21RbDfFeOsZy+MB9h52yuPy7pSWLi0Ja0HpolkXkoEnK+d7jE+XTovHPt?=
 =?us-ascii?Q?0MF5YWamg7XLgmOMHmT3hYMtFgcIWr91Duv+sJjyGYkMq14IS/v7d7g24sRs?=
 =?us-ascii?Q?dQFQrIRvJsCBgFbHYGwDlo44ddJ4dI4BlZogCldCXwMBGhw4zIq6BHApa5ea?=
 =?us-ascii?Q?iE53/Epcnik/lxIS5KctV3s8twfigb5NhU4NuEuE7QkrRaOczarh9Yz2Ad+x?=
 =?us-ascii?Q?lb0Z/JQUGD7GiV4A94/HfvthUBdSLRKPmLBjyDDhiwDT6wTQiKG7aEtiXLT5?=
 =?us-ascii?Q?3wy7hYweB8l3twmhdqLyP6VPtRpiqMIk66XNwok2tEjeljrtXgsnJmt43opL?=
 =?us-ascii?Q?wQ2iariDxBkcveCiBIU1Ko6tRm9yaCSdsiBlpDpQzc4T/w884hDK9HL7XJGK?=
 =?us-ascii?Q?jhLP43K1W9MpPrk7VeF1P5L7X1LKY/MgfyKlfV1ImoPWu7250Ud43a4Wjm6H?=
 =?us-ascii?Q?Tx2E4ReKxb/e3ndByhBlMzuUMdBZxByuRLGtamcIb3m35A1mN9UAZmtkKNIU?=
 =?us-ascii?Q?duPWMOyD3N/XnK64vv1aYzaeBqOszr0jnMvl4DkUf3cbaqItEzKIFJn7xRxO?=
 =?us-ascii?Q?GQEDKHGekloscdlX02I4qUjm9S4wjRBQNGSeQ6ZN9h0ETVFbTX8lM4c5mKVQ?=
 =?us-ascii?Q?sbg874DPGZ445OF7ezgwPrXMZ+/E3mw77eUic81/TlbfdDRmAeemku6YKMqF?=
 =?us-ascii?Q?WXfz4Fwh8wRcF9fi2lQPbyBhFHAUmmqaJCnijTfJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58a2102-8924-486e-1c8d-08ddf43c427e
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:43:00.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VKqGeCmxFufJOb9p2Kbdt0+b1ZZBUIJBBHH6RdflvsMIYdAw/woiQzwtXeD3uU9nxD1THZNUkZrpjosSUi4+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

On 29.08.25 11:09:20, Dave Jiang wrote:
> Refactor the code in reap_dports() out to provide a helper function that
> reaps a single dport. This will be used later in the cleanup path for
> allocating a dport. Renaming to del_port() and del_dports() to mirror
> devm_cxl_add_dport().

In case there is another version, reword the subject too.

-Robert

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
