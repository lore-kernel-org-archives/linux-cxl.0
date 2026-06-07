Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A44071DD;
	Sun,  7 Jun 2026 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780810733; cv=fail; b=rbiyka4/GF6nciCgOePV/7BuxmPoBPBuW3Qt5IfKWLUpgMenyfJev0KnL1gQSW6b5ZZ4CaR1/M+M7Cd0xeRtvdYqKawzyarsR7NCUmwK74KUCLItktXP4RDikaBY2T2Mdqnq/3sBCwdlrJmEW8cQu57rBXM2fah8vnAv0GTktK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780810733; c=relaxed/simple;
	bh=7K08DP+1kQGPETaCW5ZFU7bdfXEGHr+6OC8QkReHLiw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Syb9n2S4J0fFz1FfGeHCLyUtq5hpIjy0L+lgMm68oGxuhNePfrHK1vTpDB4dGoSawSw0FK5By7IEbwnSgMPXvCR+Cs7tmbfI+/Ua+d5uw3dsKdbm+pW4jaBQnk9UTqZvdvZOXF8Gxhxjs1PoOiUEpxsknhSJ1oENIHBPycksmbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MENNkD54; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MENNkD54"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzYRz1Ycv3J9XVHqXtAJ8WTsqOTCNKB+wiTQnLnbI9v9yGnI8TW9ymo5CEqJNc/agfQvile8pHHlHKITn0O5836NORcVR3mCAPQQJ2F2oc2LttA5ld0j9syAVEsxTZm4gDS5BRSxu2y4nLWYlIyAWiLX5ABxaNHJP5220msj5n9GKnytxDeAkAAxixEEMgtz2imAJmyq9gH1MNnF3LFKjR5/+AQh0Aju7s+i2GGef521VYDADQPd0mwmuInhm8motV5nzBC1usRHUBaZ/SHcI/qvfepLk2Ip31GDpuh2wtHkQyQ50q38XWXla96v8agZ8hsq0N25O+Eg/LOxabzmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNRj1v+z3S7uMpLiqCOngQ3ymfA/V3pcxpd4BnI5QTk=;
 b=vz8jBlShiD4MhskIyiya9+RoP9k/rGgJBfbJJ9gCgGXAXUsD+uqB9b/2R6NT+WaM+KADaizRbOJ/5cHgaiwy7WAckQMQlmTkkSwQrupe20bpm3IhgIKHImzEjODJ9Ef6RNrTWZZkrBgxsEOb0TU/IBz3FefAIL8kLFw5MWzjrk+se8y/IUfDixeZNZiCw8M8yLr3BYjtawwUz5NZEywZc/fM7NlFhP+MtrM34+lY8lreerqmncgIQVosvlt1JgQLib/3tggqYaGtlT2m7rKrhIC/uGPJVqz87GJLU1YwqhuvlFxtsj37R8LZhsiziZ+pTMiOhvZpD7ibJLJ7pzbwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNRj1v+z3S7uMpLiqCOngQ3ymfA/V3pcxpd4BnI5QTk=;
 b=MENNkD54cNsqLoF/l5D2rEidTPCYFM7n8E7hSDNgwwteJRhA9hOkVI4aPfIIM/rOIhPxfB29i2/2mDZQD6RZTumI/DUFhhxu3AiLjkm7L1zq6OkRaJAnED5rucm3AoTrwIeZoBYZa/xcY0T843934lZfwBBhOXjUMBM0Cld20ZR621QB/VkKoLINHaHMk1W9mD2uH57W6n34yjWeNyg9C4B0omjau0dyh0MAteqcxN2m5fjUW4qVnSJ8cHVd2MP5WiHyWlciiuOaiAdhIcRVe4HbsT1ch/Jk3augfF7LdapkfYDi7/MO77GYpXNvwfaZjjMfxmD6NJVQgMnrMOGf+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 05:38:48 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0092.010; Sun, 7 Jun 2026
 05:38:47 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 0/2] Support zero-sized HDM decoders
Date: Sun,  7 Jun 2026 13:38:35 +0800
Message-ID: <20260607053837.4389-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d7f630-1cea-4274-e62d-08dec4570aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|6133799003|5023799004|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	6MJVn7Ru9X/mDh3QhsEOGmP2VdUVBH+Em95SUZNar5ITbTw9fsccfcDLmEguGWotgy4XY+0r5lz7+I30/y94+dTAlbjE7foOpW1JExc1aKRuudsJpWF8D1nDvJkgIXK6sPenxs0s/5XZuy2ovmsZxfkGzOYjcGA21CwnsraD4BEDX5ubInF28LHDDiFZYfSkTW5dQ82BzFWGWUnHS+yZBqS/mCQlPJ0TJKTAitInvTmjie7ucV6cjoG7OCsExuR/L7nBucGKnYWV1Sz1SdtN8rDdjGzX8CuSYAxAsZ5pZDvphLwuY0DDrEBI5U980jjCmnO+XUyQlV3Dcbs6WnqSq4pWbpmAKjt2aJiJDXfXyfn1vNowQfxagfxUbWrmqZywPo77lGmEwOU1vZWim0hAhJSFjU+fQYFwkbgZfjpPfZkbw56+8CipOUl0W2Igjcxxa59VzKOQxz67KSkWClo34jrfS6LCyb2csdTYTAOfaEY/PxUN+CfzGHzngBAgeCapCW3cuJuJ61dIiuUiaNWYveX18cDwpLijs7GBcAah88A/r2Kmo9jEMDp3el02faYtA8YZY6cF/z0/eDbwXSjp2p2ekmXMgaRRzAOjg1mYLCvbRE3menTMHo3EPfmZDpDxdOpOMQTPMwCEs4e6Eet/nzd9M/l9EPOrNbvQctKUWD4uv6ybpgnV9GrJpU/mOwFCmh0krmKns7OlMIbJjFA6Vg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU9kRlloQVJIaHpERGJTRC9sb3VVUUl6cWphYVpHMTZLcGgvQlZRMkZ6MWc0?=
 =?utf-8?B?bVkySHlwT2lPTVB2TG1EMFAwTVlhZlZ2YzVyamsvVHdCakR1VE5KN1hCNFVX?=
 =?utf-8?B?cW5SNGlUUmFhL3d0eTNNYklxQ3dlandZSnJjcmVHZjNUOGN4V2tsZWcvTlhH?=
 =?utf-8?B?aXRNTTdaalM1ZUFYbE8zTS9ZQ0JEZ0tPYy96SGpoaExHdkJJQWFTZ0t5N09t?=
 =?utf-8?B?TEJJb0Z5NllsanVkbEhUK0tZS00vc0xQWXdLT3pQYWt5VkV6czZMY2h6MFBz?=
 =?utf-8?B?NFg1amtQQTQ1TnZaQlIwQlNxQzBST2czYWhESitVK2VEaWtGQ0VpYjdQZmJy?=
 =?utf-8?B?YjBXci9jcGtObTRyWmFkVlN5U3hxUWxKT2N4eFF2ZnM4UWQrTXhyUktWOU5E?=
 =?utf-8?B?R3IzZTlCK0dDbEdXY1pZSlVqTk4xZThyMFFBbWNQRkR6WkJoTEUwUU9EelVE?=
 =?utf-8?B?NVpwdEpBalk4anRxejlCTHdRQ2JwZ1F5WVcxRXRMaVZDUVpaWHhCdUdTdExj?=
 =?utf-8?B?TUt3Zm1QUU9TbExKbVdORFJnc2laZ2NSbFE3Ky9RREpFZENwV1I1NzhRcDVo?=
 =?utf-8?B?YytpYTZWRUliR1JYTmx6RXhpQUlCdW5ZVys5ckptS3c0YndyejAwN01Tand5?=
 =?utf-8?B?RlZxYlI2V2ozb3B2T2s4YjR1b1NIdnQ0eWphTm9BZmtHUHprcDFJdWpYS2ZL?=
 =?utf-8?B?Rm9kVHhKSkhhVXMwaHZsc0VGaWhub256UFpiSUdZZEk5Qlp3c3ROREVodm41?=
 =?utf-8?B?YmloWEpSeXVMS0R3TkdqTlBuSzRTcS9Udkd2U0lNT29rZVJsbG1jek03ZlRI?=
 =?utf-8?B?Ry9DbWV5TmYzeExQZmxpZk4vVE52ZUUzWUJsUzRQbVVRNUN6UU5nODFWUE84?=
 =?utf-8?B?bzN2T0NyNVJTcmFnc0hzN0tiNEMyRzh4KzJ6dDlwL3lNbiszcGs2aTN1Qmh2?=
 =?utf-8?B?TVB1a3RuelRRUERKVDYzOXpUeTQrcmdKRjhvMXhNeHkxQjFTVTRWUlU4emZJ?=
 =?utf-8?B?MFdrRlFzNXljUkpSV3hCT00zb280TmpycEtWRlJuUFczK29xSnFtQkI4L09o?=
 =?utf-8?B?amRMSkpCa1MrTzVXSkFYODJCbW5tWGxxazJjNmMrT3FPaStERnUxai9XR3do?=
 =?utf-8?B?akxTTmtxelViNjgvb3JZb1J2alQydDF1dmgvV1NPWDJMVDMvaTlkdUpFT1lH?=
 =?utf-8?B?bWZZVmdmYTBPV0Y4RGkxelNRbzNESysvVWRTenhTOFBTSFpwTnBROE9ZbnRJ?=
 =?utf-8?B?TlEvOE8vaVpUQnNOOEdCV2xjQ3pTZ0hjZmM0OXNBRHM5QkxZK09ZUmU1eEVN?=
 =?utf-8?B?UEhvWlBUN3VJakI5TTkzdEtuelFQY1RIcFZwNFFuakVDNXZmSllVT25kZW1U?=
 =?utf-8?B?TVFUNVYxZytETUxEbWdWakIrOURTOW41QW4zYTZ6ZGNtcEEvbE0zN2o2aGhw?=
 =?utf-8?B?bzVYdEtqRlY4SWJ1WmVFRXF4UkFYRHlPVHlWZjlQdTJlKzg5elg3amtTVHZS?=
 =?utf-8?B?VzYyRC9aYW91czN0TG91cFNVSysrK1dMRnYzSmpzNXo2YVoxa2NoVmZTVm44?=
 =?utf-8?B?cUNEemxJemFOWWM5MEJsZkRTMlcrNkcwSkdlQmRFajVCczRNSW5hWHE5U0lr?=
 =?utf-8?B?dnFZcWpyOSs2bk5pODRpVUN0d25pc3N2UWJ2T0FaOXJlaTI2dzRUTERoRTJW?=
 =?utf-8?B?RGxPMkRNSVk3aWZESUVoUnlyNmhsUGJMdm5XSnlTRzJYalBzdm1kRzUyd3dZ?=
 =?utf-8?B?cHdrK2R4dkM5V040WkR2bGhaQWdKaE10bkpOTC9hWVgzNEMrTlRPQWVOQ1dU?=
 =?utf-8?B?bGFrMWJnaFVuTmRDMm1ScU1RZXZaVG5PZ1RSNHBqQ1kvUXJLNGtzNHQ3SXZB?=
 =?utf-8?B?L2hyRUpjQmkzT01TUWdGUTliV1FzSVB0VGI3SGlscWJ6dmdNUWIvZDN6UmhH?=
 =?utf-8?B?Zll0eTJrT0YvVW0yTVJ6aFUzUCs3cXFTTnlGUmNlY2NwOVdxWG5pb2FtZ1pH?=
 =?utf-8?B?cUZmSWNCaFhWTEoxZVNrU3k1bkI1YkRqTnIzYXVIR21YZFUrWDRoZEJYclFU?=
 =?utf-8?B?VWlVeFl5bFpjRzVPMkd5N3dSYmViZ1JxcTVkR1hEeWRjZll0anlnNkdCVVkv?=
 =?utf-8?B?LzA5K1dGOElkL3R6MHYrOHp4Rm9nQVkyRll1bjAwd3piaUJGTThVWmlsbHhv?=
 =?utf-8?B?VDZENitNU3B5MWNGREJWd1VDMGU5MXMrV00vUDE2bkRaR0JNbDR6cFRGbEZO?=
 =?utf-8?B?VXBVb2lRRDdlSGxib1JTNE13VnQzbDlNeFRxbmQ0SU9KekMxc1hpTFd6SU9R?=
 =?utf-8?B?TGkxSmlCVUt3UUlKRWgySXhsQWMycERKZlVhU2syMkp2Nk9UMGdOQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d7f630-1cea-4274-e62d-08dec4570aa4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 05:38:47.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie2pprptacaLFvlxMR2k1iAddFfwZ5lu+HGVtXY/kESFV4sQyagF3hjANvF2pt+BrUeXVI1nyjuHFXzaSE9gNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

Hello,

This v3 picks up Vishal Aslot's "Support zero-sized decoders" series [1]
and addresses the v2 review feedback [2].

CXL r3.2 §8.2.4.20.12 and §14.13.10 permit committing an HDM decoder with
size 0. BIOS commits and LOCKs such decoders to burn slots so the OS
cannot program new regions through them, e.g. for a Type 3 device in a
Trusted Computing Base (TCB) established via the Trusted Security Protocol
enumeration and aborts the whole port, so affected systems show nothing
under 'cxl list'.

Patch 1 enumerates the committed zero-size decoder into topology with its
HW-reported LOCK state, and resolves the two v2 review issues:

  - hdm_end (sashiko-bot, Alison): the zero-size decoder skips
    devm_cxl_dpa_reserve(), which left port->hdm_end un-incremented, so
    the next committed decoder failed the in-order check in
    __cxl_dpa_reserve() with -EBUSY. hdm_end is now advanced.

  - poison (Alison): commit_end can now reference a decoder with no DPA
    resource. poison_by_decoder() returned before the commit_end check,
    so cxl_get_poison_unmapped() never ran and unmapped-tail poison was
    lost (cxl-poison: 4 expected, 2 found). The fix is folded into
injection behind a new mock_zero_size_decoders module parameter
(default off): the shared topology is unchanged, and enabling it
reproduces the BIOS layout (auto-region at decoder[0], zero-size+locked
above at commit_end).

Patch 2 adds cxl_test coverage. v2 committed the mock zero-size slots
unconditionally on the host-bridge0 auto-region endpoints, which the
region tests reuse, regressing 7 of 17 cxl unit tests. v3 gates the
injection behind a new mock_zero_size_decoders module param (default off).
The shared topology is unchanged, and enabling it reproduces the BIOS
layout.

Tested with the ndctl cxl unit suite: param off, no regressions; param
on, cxl-poison's by-memdev-by-dpa case returns all 4 records (2 without
patch 1's poison fix).

The result is in the following:
"""
$ sudo env "PATH=$PATH" meson test -C build --suite cxl \
> --num-processes 1 -t 6 \
> --print-errorlogs
ninja: Entering directory `/home/nvidia/ndctl/build'
[1/50] Generating version.h with a custom command
 1/14 ndctl:cxl / cxl-topology.sh               OK                3.38s
 2/14 ndctl:cxl / cxl-region-sysfs.sh           OK                2.60s
 3/14 ndctl:cxl / cxl-labels.sh                 OK                2.53s
 4/14 ndctl:cxl / cxl-create-region.sh          OK                3.25s
 5/14 ndctl:cxl / cxl-xor-region.sh             OK                2.61s
 6/14 ndctl:cxl / cxl-events.sh                 OK                2.46s
 7/14 ndctl:cxl / cxl-sanitize.sh               OK                5.42s
 8/14 ndctl:cxl / cxl-destroy-region.sh         OK                2.47s
 9/14 ndctl:cxl / cxl-qos-class.sh              OK                2.54s
10/14 ndctl:cxl / cxl-translate.sh              OK                0.78s
11/14 ndctl:cxl / cxl-elc.sh                    OK                2.45s
12/14 ndctl:cxl / cxl-security.sh               SKIP              0.02s   exit status 77
13/14 ndctl:cxl / cxl-features.sh               OK                1.27s
14/14 ndctl:cxl / cxl-poison.sh                 OK                7.91s

Ok:                 13  
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            1   
Timeout:            0   

Full log written to /home/nvidia/ndctl/build/meson-logs/testlog.txt
"""

And the tests Alison mentioned.
"""
$ sudo env "PATH=$PATH" meson test -C build --num-processes 1 -t 6 --print-errorlogs \
> cxl-region-sysfs.sh cxl-create-region.sh cxl-xor-region.sh \
    cxl-destroy-region.sh cxl-qos-class.sh cxl-poison.sh
ninja: Entering directory `/home/nvidia/ndctl/build'
[1/50] Generating version.h with a custom command
1/6 ndctl:cxl / cxl-region-sysfs.sh          OK                2.62s
2/6 ndctl:cxl / cxl-create-region.sh         OK                3.15s
3/6 ndctl:cxl / cxl-xor-region.sh            OK                2.61s
4/6 ndctl:cxl / cxl-destroy-region.sh        OK                2.39s
5/6 ndctl:cxl / cxl-qos-class.sh             OK                2.47s
6/6 ndctl:cxl / cxl-poison.sh                OK                7.80s

Ok:                 6   
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0   

Full log written to /home/nvidia/ndctl/build/meson-logs/testlog.txt
"""

[1]
https://lore.kernel.org/all/20251015024019.1189713-1-vaslot@nvidia.com/T/#u
[2] https://lore.kernel.org/all/cover.1779957270.git.icheng@nvidia.com/

Richard Cheng (2):
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoder under hb0

 drivers/cxl/core/hdm.c       | 25 ++++++++---
 drivers/cxl/core/region.c    | 42 +++++++++---------
 tools/testing/cxl/test/cxl.c | 83 +++++++++++++++++++++++++++++++++---
 3 files changed, 117 insertions(+), 33 deletions(-)


base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
-- 
2.43.0

