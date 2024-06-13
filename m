Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58499652
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238700; cv=fail; b=ZB7wfvk/3cMIcqXkcdGumTVpgz1Wo3yNyvesBbKNYeFcL9oqL1p57PW5cUkJ2u1gvhCwuF4vjNbruGvYswB+MHyrcS4d9z2PnPSf+f3gMn+XubXZA4rYSZOEV6ZaIlsVqHu8Z7CpzgfevvBdXnmvb1z4vXIgv2X33H7Ubh/6DRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238700; c=relaxed/simple;
	bh=MrYOjt/ihYUEWz9f00wcTt+HGS4ucYP5L2Ye0bFfkQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VSruN5/SszSr6U0Q9l3YzRXyTHK+Em45tdZBUXyC7EQ5cFsKGKaGovdIl5WB+r/ymzy+j6wO/xJm9SnhkW5mcyiMINyMXwFRG/smgyMqodwYWgFUyqPVsWJuqAWNiLFw7XPsoq7vzJb25YZsby41DFMkYlagfp79QsfKIFuy8rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FOCHLZh3; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FOCHLZh3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1718238697; x=1749774697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MrYOjt/ihYUEWz9f00wcTt+HGS4ucYP5L2Ye0bFfkQc=;
  b=FOCHLZh3dvdyHzOTOjN4U/N95ePKrjhTeumg990eibR+PaEYDZWjBM82
   KwuIRL8SDQbrPlGGDzSFztgUSrvW1R+ZyVNrv7TiXDt+iMk6iI8rZAv0O
   IQRRDMAvcEMzEfyjBFHHg/ckpLxW/8o1oQ5gpDkiIR8kRWVtcqQJg1IgZ
   C70R94YvQ6ps9AZhfi4K9bqkcNszgixJfa2yigSI2ykQMaAJzQJnHE81D
   zA5N7umOheBIBnpghSrUKbGDalvVK6SE+k6250qslqSvE9eoxKRIuIK1C
   9Uw7WUQud/caQIx2PxXM4LnKM9W34L5kJ6RD8kLkUIzLCcmwoOqBD2WoC
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="121747211"
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="121747211"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:31:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0dRHByrs1eOz7sG+Lk+xyM2It0GcTQo6LrZZbQwtZ/iqWL5OvRgD0fkf3Jzik9fg7jiy0goZjToo8ZSAhRW2c0CqsP8vOepyUfIKN+zpmZ+1xU4M9K+8sh8NaBL1RE4RbCreu26PMYFab3BUpL5gwdCuEfDAb53CFLp4ODkULjMHw3hnKgaGFSWRGh2zoZXK8kRfkL7Z72MNJdXEbeBElPboEhzVaZkOFpemXwZtvNtMMLgvnmnt3ax2OYPhxOPiq375MBI9gtqEn9Jk9SYEhBLdUjlkTRM9zKWsPyujEF3DNG4iVwUmyclXY4pOsYrCd/3T3d9B3wzUYgTFPypLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aGrts9W8mh3ejBSJeCYG3Td2p4rQIGX3ErAfjIMU7w=;
 b=jq+BHGKjb2RW1MALpBbx+K7orC28KCrK6IoGOrwCTUJpVrSJXt1DLqDVMmWPIU5ET5nXm6SjoykbJ5lfJBsBaBBb92esiPj1GXm79m+DtyM4iTZjVc6Q2fzgA4NKCh0ojY/CTcyiNEWuspabZ1i81Owjz2hji4O7P0qpAZ8u3oL/qPEE6QIWbVEia4c3Ilbp1O6p7wPOqTWnKD1MqY2+l3ey6QX+llr/Ycb8T0dQvN8hsSuQ9/QJWOhas2R9ujnt9YEjhMZpEng45Z9/zkQpS/yi/AjgLEIv0N18hm/GCnlS62sJwwE4oEpHl4LY81CkWq61JEjczKLoS0u5vX0z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSOPR01MB12313.jpnprd01.prod.outlook.com (2603:1096:604:2df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22; Thu, 13 Jun
 2024 00:31:28 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 00:31:28 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v7] cxl/region: check interleave capability
Thread-Topic: [PATCH v7] cxl/region: check interleave capability
Thread-Index: AQHavHg+kayOu0TIlUazgRKg5v7PCLHEXCaAgAB3HyA=
Date: Thu, 13 Jun 2024 00:31:28 +0000
Message-ID:
 <OSZPR01MB64535881EDC218CC208542168DC12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>
 <ZmnVCxoMissgIPxA@aschofie-mobl2>
In-Reply-To: <ZmnVCxoMissgIPxA@aschofie-mobl2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8fa5b8aa-64b8-4c23-8c25-d218c1858918;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-13T00:10:38Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSOPR01MB12313:EE_
x-ms-office365-filtering-correlation-id: 11227227-b23e-4801-fa21-08dc8b402a5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230034|376008|1800799018|366010|38070700012|1580799021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MlpwT3dqa0dNZFgzZDlBNVZONFZyNEhxblZreko0QWhnQ3p1TmNpSkw1?=
 =?iso-2022-jp?B?S0VUZVEybW5zRHZ4ZmRNZ0pQWFZ5UHNrZU8ySTN5TlNTblRxNDR1cGhB?=
 =?iso-2022-jp?B?UEFrekVrUm03eEVFck9mQU1MU2pLd2k3amV3eHRkWnlOVFVNdlpXally?=
 =?iso-2022-jp?B?SFN3d2MyU1UvMmV5LzMwdzJmK3BFRWl0eC9jaXc3eUdBUHowbHRpU1RV?=
 =?iso-2022-jp?B?Q2h4Nm9nbEg1Mm53UGRSZWc4ZmhKYkhiUFF2WHlrZ3pxUzJNOVVQcm1S?=
 =?iso-2022-jp?B?NXJOQmxsMnNsUExnK2xWejhndHI3U0FheE5xWEdEaHAzY1pDdUxVWkNE?=
 =?iso-2022-jp?B?SzQ3YkRsbU02OWpQNUprd0FXcTFXQkFTdURNckdLRTFvS3NkKzU1QlZS?=
 =?iso-2022-jp?B?UWNlZ3hoWnQraXpoWmhvYlFnM3NzS280MnBaUFBubXNjaXlFaVFFekNv?=
 =?iso-2022-jp?B?TGkxYnFVUDdKNFRNbmlqc2psVlZhV003cmp2dWRNL2hVK3BSRlFTY0Qy?=
 =?iso-2022-jp?B?NzNKM2hnOUU4c0wwYmxTMzQxeXVzMXNCQnFpeWhKNG9PSGpoK1FqQkhC?=
 =?iso-2022-jp?B?Q3IyOE1IT2tSQjdwY0pNeS9SRXRkMTI2dUt1QTV5cllvbHgxTXRwUUF6?=
 =?iso-2022-jp?B?Qk5WZXNIK2k0SEJTY2VQbHZZclZiRXJSblRDVmdWVlg2VnEvbXY4ZnBr?=
 =?iso-2022-jp?B?REJiQ01XVExnMVVBUTBCNU5VbGRkZDEwYnBOdzdkYkEyNEJTMGxHeFd4?=
 =?iso-2022-jp?B?dmkxd25wcHNwZXo4M29KaFFPdCtRQ2ZWckN0ajJpZG5YaVBDMDgvNDJl?=
 =?iso-2022-jp?B?TWZhN1RSNGpuZDhQcURGREpxRTRmVzNLeGtCcEJCRE1TcDFqbXh3MnRl?=
 =?iso-2022-jp?B?c0xFUUMyZ0EwUzlTdllld3h4bXJZSmYzT2RaSU4wS01aZlRKQzBBOFZX?=
 =?iso-2022-jp?B?TFB2UHBJQWtBRnNkUnBndU1sS3NBdDhFNExwbVQ0eTBRWGZoT3g0WWxt?=
 =?iso-2022-jp?B?dHRuVWxpVnZJbWMwWTBhM0t1TkxnRjVtWXRpeE5RcG1aelZoM0dJVjdN?=
 =?iso-2022-jp?B?STNCNkNhRkg5RXN6MVUrSysyNmtyNmpsOXBJOHNzUnFnbnlWQ1BTTUdM?=
 =?iso-2022-jp?B?NGx4TnZzQTkreWZQUXUxMmZqaVlhOEt4L3VnSGE1Q0ZwK2xHMkZ6MXdL?=
 =?iso-2022-jp?B?S1pZelo1RXY1VkVIQlFUTEpoK1E5NWpLcjZmRkxmdHcvb2xBdDI4UENT?=
 =?iso-2022-jp?B?VnIzZUswb1Y3R01iQ1huelI1aDVhVVA0eGNRRzIvSExyOGZXY09kZGdQ?=
 =?iso-2022-jp?B?aXN6OVpvTmU4dGJmYkFLVXZFTmJOeW1MK3E2ZjVqVGk0c3hJVUV1YkQw?=
 =?iso-2022-jp?B?TExpaUhoWjFEQ2MzWEhsV1k0M1lqdnhreVBOeG5RSGFJbkNLcERCT3Zy?=
 =?iso-2022-jp?B?a3N6Vlg4YkhwdnA1SkMwQXZoOGdkNUo1aFUwTEMvZ1FqYTk0SHJZZDZk?=
 =?iso-2022-jp?B?aEthSm5EWEFBeEljQlZiRStzWk5GOGJCaENDN05lSVZVQzVMOGpvNVM2?=
 =?iso-2022-jp?B?WFlSUUFsQXNMVkRMY0labmpneUtPZTRkOHBna0dFTEFrMHJqRVdVYlBE?=
 =?iso-2022-jp?B?WTU2V3ZrZVpsWFVyTjJodmNIOHZsTXZzNXoyQ0JYT3FlNjltd2x2YmE5?=
 =?iso-2022-jp?B?NEMzK3c4NnFERzY0Q2JRa3Vpa0x3d1FPcFVYWitHT0RpMzIrVjdQOUR4?=
 =?iso-2022-jp?B?SGxZWXBHQXVVZXJhTXhLOTVNRVRmcy90SjlDb1dPVHRKY1VNK1JJVVR1?=
 =?iso-2022-jp?B?Z1hrMnBvSVJsZHo1d2k1Vk1hUFJIc1hBREIxNzFFQXZMNTlFb0N0ZnNY?=
 =?iso-2022-jp?B?bUxwWlg0RFBzRStoWGlybUtpSTk0RjFDcWxHcTUzS1JYd1RkZWpPK2F0?=
 =?iso-2022-jp?B?am92Slg5eDZpM041SnJlbVljZGtCanpxandqdTNuQVZaejIrVW9tcGZO?=
 =?iso-2022-jp?B?UjVvYlAwcjQ1bHNqUkh4QmZObksyT0J6emlTMmVGcC93MjE5VGtnNVk3?=
 =?iso-2022-jp?B?cmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012)(1580799021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UUNtZzNMRmREL3RxRE1rTTFxZnlYTlpqYjNZZWRVbUMyNlJldmh5alhV?=
 =?iso-2022-jp?B?ci8vTzVneVhMK2g5VGFpTzhPVTBDNE9NRUV4WnhjTFFOWWhYQWJrVzdT?=
 =?iso-2022-jp?B?WnU0eFJQN1oyeEROVUFKVVRNc1h3NVh3bjl5YnhLcVdpK2JoQzFjYkVk?=
 =?iso-2022-jp?B?KytjVGRKNDJqNGI5N09RQVh4U01DVVJnNXBOVzVuZjRpUzZQTWlFSmZT?=
 =?iso-2022-jp?B?dmNnb0ZSVXRIc3RhOVJtc0VPelhHcVl3dnZjcmtjL250WUF5WWtYaDRm?=
 =?iso-2022-jp?B?dVpxTEwzWVBkQU5BYVZKUDM4b0ZRdTdZNzhHZi92UGdYbGtUTGU2Kzdh?=
 =?iso-2022-jp?B?VENSbFkzU2RCbW1CSFhaTEV6alplL2dxN1ZacU14QkFia2h6bkRzUTAw?=
 =?iso-2022-jp?B?UWpqSjZkSWpQMWo4TUdueTVkQXZ1OEE0Qmc1ZzZvL1dUc293NlcycVlT?=
 =?iso-2022-jp?B?Vm11WG9WblYrTjFzTWIyeDdGczB5bWozdXREOE9Dcm9LNEpGcmhsZ0dN?=
 =?iso-2022-jp?B?MkZCYmo4cXVhemVxWFFIQ3JBWEZFZG9ZWkNDdWEvejM2SlNjaGU2QXUx?=
 =?iso-2022-jp?B?ZGorbXFEV0hod21RenIzMDN5ZHUxZWoyS2hJSk1DTXV6ckJwVFU4REUx?=
 =?iso-2022-jp?B?VFZiMW1aRTkrRnJ2SFlUMjE3OXFJZnRnd3RNcndLV1JpcEFNbkllM1lW?=
 =?iso-2022-jp?B?NnBRN3ZHRDIwZUs4dG95cXZxWTBnM3dKZmUzQ05rMGFNODZYQXhCVE9E?=
 =?iso-2022-jp?B?VHhRWmV1allJRE10RWY2THNMRnFLcDhMR1BOYis4NzZwRjF0T3JHYVJJ?=
 =?iso-2022-jp?B?Ykp0c290K295MCsvNzQzcVNsRzhYdUNLWmxrZSttcHNBN0Y4UlIrTzBz?=
 =?iso-2022-jp?B?Z1pwS05Kcmhlc0R6SnZsTlVtY3pkN1Ztd0tTeGJsemlHSGlDN09CNkZ1?=
 =?iso-2022-jp?B?b3V3a3MySnEzelJEUVNCbHZoY3BwUWlGRlBkVy9mdzFaN1JlZDVPWXVQ?=
 =?iso-2022-jp?B?SkJpbGNEUTdaeER2NDBVN1FrR1J6RG1IZGsvM2xQZG1OWk1xVWNIam56?=
 =?iso-2022-jp?B?S3REQldwZDNlcmdTdU9BMnlvZkhwTER0MGJXSVhQaFBXQVRJUEUxc2ph?=
 =?iso-2022-jp?B?Ynh2VENqM0tGSTZzMS9pOXh2TkFnUys0OC8vUjFldDc1ZkcrSFFYREE5?=
 =?iso-2022-jp?B?RnlicHBYTDhSNWxnZWNvb0NhNzBFdWRwS0tKWmFxNklWS0FZNmtaSmdL?=
 =?iso-2022-jp?B?YmlCbFY0NTA5TUQ1bzlUMzFSVkJncFAyMnNJVEI4YmN4UzhkWTNFb1Z5?=
 =?iso-2022-jp?B?MGJYODlYMmpFNThDY3BLakdtZjNBSHptZHlIdktETHd1STRiQ1dWNnJs?=
 =?iso-2022-jp?B?UUpTWVJsRkczN3VDTGxIUkswMDIyRFpVajI3U0lQemkzQzd4Ykk2N1Vh?=
 =?iso-2022-jp?B?R3QrMGVsYktpU3hBNUQvbUFENlhaNnp1d3BhaGxQblZGUWJFV3RrQXF0?=
 =?iso-2022-jp?B?ZUpxYmFOZnZBeERGUlNrcWZIbVV5ZTQ3TUtuWjZGdmhsWExiVVZFb1lD?=
 =?iso-2022-jp?B?UEROUCtkeldjRTg1V245QS81TXNSSEJ0RmFwVXlnTi9HUUR4T0RTZk5C?=
 =?iso-2022-jp?B?RGZ0M3NYN05IWWxZaGY2WGhwODlPS1U4NldrL056cjc1bS9ydllLek5G?=
 =?iso-2022-jp?B?WHFYTGtIWlRiQVBUUVQyQkYrRCtoRWVtWDBpdk0zMDNvM1pRangvZnhm?=
 =?iso-2022-jp?B?eE1oTjRNUXZ0cG1MRGFjVUY1by9lbks2VG1ZZ1kyYW56QmJTeVhKSlRZ?=
 =?iso-2022-jp?B?RGdqU1liRm1wTTlrMjdJQm5yQlltUWM2V09zdzNWK2sxUEVCZy9jM0kw?=
 =?iso-2022-jp?B?UlRIMkNYaElIbC9SMjhmcjhHMSthUWVOVWdWV0wzWjU3SzArZUVKcFMr?=
 =?iso-2022-jp?B?ajhEaDdpNVUrd1BRWVE1L1kwY2l3OTFMQ0dha1V5NVhsbm04T0dQWGQ0?=
 =?iso-2022-jp?B?VzEyQmtUV3FFUW96eTd2Rk1hUWlUL1hWK1NIK0c0dk1LMnc1UUNrMWla?=
 =?iso-2022-jp?B?UTBmZmxiMFlOTExNTXFuOTVFdjEzVGJIZlYrUzk5RlN0NE5iSDJGVXM2?=
 =?iso-2022-jp?B?MjZJT0xiY2FsajhhNVBaNEdObG1CYXExUC8rNjNxRGsvaWRLVWozVmND?=
 =?iso-2022-jp?B?dWVCYm1IOWdyamFmOXExU3lEVWtzdks5L0ZJSE05MTR5cmhjcytCaUdi?=
 =?iso-2022-jp?B?b2Fua3NadVIyNzZTL3pUYkk1Y2R0M0I0WEdQcjlyZ2c5TUVlRGRCYWFX?=
 =?iso-2022-jp?B?cmRFWg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/7ScxRMcchnx4LVpGNWOku/cOHWb0XU6CtxlGnarCX/AEUG8C4flYqTNvu0SBiq+zSGdkvKUGUQArpo2lnRchbfjRkfG1ZXrcJUL8m+M9HxgM0VuK5tJjsvGEAEkp4egv4iJU39ClumKRHc6f/TC4790NWnbt/jV1wXKFg86/lOe8+VKyFNdEJd/gz77TQm2H7mJn7kWRge+uJeZGWMCnujzr3LcShxJ7AvZODGIUjYW5IE3cnvWU8AqF0HMeY1YUlho1H36HG44IflUgNlynFkOklkMDGPyuUB/sOyKUCbgAuKQxzfXotpT1O3AHuebydQgwgmqJcnqVSNFJkQyCiYVji0udlocizzmtwigaXnkFo6TWKQv3K0PzXv9jtoBEQb3ho1CLXJ8zA7Y+Kx3FMOJ34/6qYiW5/uZqxVFyiPrMHuiZwPGHTygWD044gQlfuGF42nJDqLEWNQoAvxIaHemBL1tL3L9bA5MlReFzB+nfJRDzEu/rVTfk0qTa+hvtMCf9QKyEivteNCQbuy+/iQfEZuvGEdzzp4L7kJzKqZs4mxe/46RoUOUO0jf5CgejaGe1srN4WP9AoHgIBepwoSXNzQq6r6RE75wSlQB+DEt4k3UHYIgk1Mb8G2P5G55
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11227227-b23e-4801-fa21-08dc8b402a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 00:31:28.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CPUMBywiefoaC27aaOChIURQ9Sxc1WbFsI1CiiWU9/gp+98ZFiX8lCjlDGs8NqPGSJNsB1HlhmAzw2omxlnAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12313



> -----Original Message-----
> From: Alison Schofield <alison.schofield@intel.com>
> Sent: Thursday, June 13, 2024 1:04 AM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v7] cxl/region: check interleave capability
>=20
> On Tue, Jun 11, 2024 at 11:25:44PM -0400, Yao Xingtao wrote:
> > Since interleave capability is not verified, if the interleave
> > capability of a target does not match the region need, committing decod=
er
> > should have failed at the device end.
>=20
> This needs some fixups to pass the cxl unit tests.
thanks, will fix.
>=20
> snip...
>=20
> >
> > +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int =
ig)
> > +{
> > +	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
>=20
> Tried this out with cxl-test and NULL ptr deref trying to load
> the cxl-test module. Needs something like this:
>=20
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 3482248aa344..f7ed3dd19992 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -630,11 +630,13 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct
> cxl_port *port,
>                                           struct cxl_endpoint_dvsec_info =
*info)
>  {
>         struct cxl_hdm *cxlhdm =3D devm_kzalloc(&port->dev, sizeof(*cxlhd=
m),
> GFP_KERNEL);
> +       struct device *dev =3D &port->dev;
>=20
>         if (!cxlhdm)
>                 return ERR_PTR(-ENOMEM);
>=20
>         cxlhdm->port =3D port;
> +       dev_set_drvdata(dev, cxlhdm);
>         return cxlhdm;
>  }
>=20
>=20
> After that, we do load the cxl-test module but the autoconf region
> fails to set up and other unit tests fail trying to setup regions.
> I didn't go further into those, seems all failing here:
OK, I will find the reason and fix it.
>=20
> cxl_region_attach()
> 	dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
>                        dev_name(&cxled->cxld.dev), p->interleave_ways,
>                        p->interleave_granularity);
>=20
>=20
> -- Alison
>=20
> > +	unsigned int interleave_mask;
> > +	u8 eiw;
> > +	u16 eig;
> > +	int rc, high_pos, low_pos;
> > +
> > +	rc =3D ways_to_eiw(iw, &eiw);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
> > +		return -ENXIO;
> > +
> > +	rc =3D granularity_to_eig(ig, &eig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/*
> > +	 * Per CXL specification r3.1(8.2.4.20.13 Decoder Protection),
> > +	 * if eiw < 8:
> > +	 *   DPAOFFSET[51: eig + 8] =3D HPAOFFSET[51: eig + 8 + eiw]
> > +	 *   DPAOFFSET[eig + 7: 0]  =3D HPAOFFSET[eig + 7: 0]
> > +	 *
> > +	 *   when the eiw is 0, all the bits of HPAOFFSET[51: 0] are used, th=
e
> > +	 *   interleave bits are none.
> > +	 *
> > +	 * if eiw >=3D 8:
> > +	 *   DPAOFFSET[51: eig + 8] =3D HPAOFFSET[51: eig + eiw] / 3
> > +	 *   DPAOFFSET[eig + 7: 0]  =3D HPAOFFSET[eig + 7: 0]
> > +	 *
> > +	 *   when the eiw is 8, all the bits of HPAOFFSET[51: 0] are used, th=
e
> > +	 *   interleave bits are none.
> > +	 */
> > +	if (eiw =3D=3D 0 || eiw =3D=3D 8)
> > +		return 0;
> > +
> > +	if (eiw > 8)
> > +		high_pos =3D eiw + eig - 1;
> > +	else
> > +		high_pos =3D eiw + eig + 7;
> > +	low_pos =3D eig + 8;
> > +	interleave_mask =3D GENMASK(high_pos, low_pos);
> > +	if (interleave_mask & ~cxlhdm->interleave_mask)
> > +		return -ENXIO;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_port_setup_targets(struct cxl_port *port,
> >  				  struct cxl_region *cxlr,
> >  				  struct cxl_endpoint_decoder *cxled)
> > @@ -1360,6 +1431,15 @@ static int cxl_port_setup_targets(struct cxl_por=
t *port,
> >  			return -ENXIO;
> >  		}
> >  	} else {
> > +		rc =3D check_interleave_cap(cxld, iw, ig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s:%s iw: %d ig: %d is not supported\n",
> > +				dev_name(port->uport_dev),
> > +				dev_name(&port->dev), iw, ig);
> > +			return rc;
> > +		}
> > +
> >  		cxld->interleave_ways =3D iw;
> >  		cxld->interleave_granularity =3D ig;
> >  		cxld->hpa_range =3D (struct range) {
> > @@ -1796,6 +1876,15 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
> >  	struct cxl_dport *dport;
> >  	int rc =3D -ENXIO;
> >
> > +	rc =3D check_interleave_cap(&cxled->cxld, p->interleave_ways,
> > +				  p->interleave_granularity);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
> > +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> > +			p->interleave_granularity);
> > +		return rc;
> > +	}
> > +
> >  	if (cxled->mode !=3D cxlr->mode) {
> >  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> >  			dev_name(&cxled->cxld.dev), cxlr->mode,
> cxled->mode);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 036d17db68e0..dc8e46a1fe82 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -45,6 +45,8 @@
> >  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> >  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> >  #define   CXL_HDM_DECODER_ENABLE BIT(1)
> >  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 36cee9c30ceb..7fe617122d33 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -848,11 +848,21 @@ static inline void cxl_mem_active_dec(void)
> >
> >  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
> >
> > +/*
> > + * struct cxl_hdm - HDM Decoder registers and cached / decoded capabil=
ities
> > + * @regs: mapped registers, see devm_cxl_setup_hdm()
> > + * @decoder_count: number of decoders for this port
> > + * @target_count: for switch decoders, max downstream port targets
> > + * @interleave_mask: interleave granularity capability, see
> check_interleave_cap()
> > + * @iw_cap_mask: bitmask of supported interleave ways, see
> check_interleave_cap()
> > + * @port: mapped cxl_port, see devm_cxl_setup_hdm()
> > + */
> >  struct cxl_hdm {
> >  	struct cxl_component_regs regs;
> >  	unsigned int decoder_count;
> >  	unsigned int target_count;
> >  	unsigned int interleave_mask;
> > +	unsigned long iw_cap_mask;
> >  	struct cxl_port *port;
> >  };
> >
> > --
> > 2.37.3
> >
