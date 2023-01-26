Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82616C54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 22:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjAZWGJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 17:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAZWGI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 17:06:08 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E5B5DC3C
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 14:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml/VQYIB8vG6hCC0N51oIpVPPSUliJnT41YaREN5jS3IUYG2DhCYZUi0QpomyUT6dLmQE22jb+nccOvW1pP78P/5eGFXjUyDJKq+RIJ9t8VyfcTDaht4SatzbN5ckFvspyD5J+iemm+AoGJoFeDXAeMOAcm+vO2lZOu1bYtpBlXYbUw6WSEo0LN+X9+FkHeluvQt5nxuwUz9Evn49WN3dUqTJm2SarBak6v8llmuIcrhrFZbs2MTnlls0fckzmMEgOWABqYEV1SMT4ZcYu5IEosHx2dhtblR09gCZHpQY4StH7kWxKDnJzzPn3gU2mmse1jdnqTkZVq9whvLzEpPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiablQz8t7MlooIqcPdf3jeCr/89bM17gEvVNSXFPsc=;
 b=gDDROUGhwH7NmSsbYdZzpl10paxxY1EX1OTzujj/hR2hyp+AXnFOiaFnVIlMmI2c2RXXv88563TeyJpmGE0Hj90ZJsgYyIAZif52Kl4DvwSZmWj76v/Og0scTfzf6ZiNV5b2I6PRifi8cMHP/6iIUfXcT9nX5fQjfdAB0vBBETiORxsDVstwJXcj8rO91g25Kxfjf5dCYQEkYh/VJWh5DmjR3TkOo97Cp92SQ0ZJeYd9dsy/7kTFtNMZiWjhtHdWPErw7zF7mgLM2MC4juUoUU9rfNtMwEiXH4XjHlM8QeNg8LY56sBJ011HWLmXbHeFGz1uOPWD9qWX1hnzk7sS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiablQz8t7MlooIqcPdf3jeCr/89bM17gEvVNSXFPsc=;
 b=GElJLXXeKBKQnlakZu8H3w28UcBkndsTxXEbSFfJaIOeFbYU0MYeQFXrfVApnO1gDNf/6q9B8U+M+5bmIpWjpgQz1ncnDDU7MGSgchuosaJyErp6g2woXoUE1RchWBNwrpMBMAN8G3WczgKb4CzAs4aANMk/OqKKUcnXbULY3nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA3PR17MB6874.namprd17.prod.outlook.com (2603:10b6:806:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 22:06:00 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 22:06:00 +0000
Date:   Thu, 26 Jan 2023 17:05:56 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9L5RGZc5lcV2Ina@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BLAPR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:208:32d::20) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA3PR17MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: dddd39ef-3d12-4b3c-5c0e-08daffe981df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ar5MgqFn7bHfcmyqjF3CeAKONjA4Ea9TrypHNCCeXOuyTOoxseNrjL3Ui/KHqGWhdgaNYhgruZg4G+HXWldeAGYrftNMCdGpAnWuF6ipO6nJiRloTK0prKBGAcwjn02qRa3f7BNCpRPPVhQcb8Oq3Lv+ilictNkUmE02CFUAR83Nd2vQOT0bwdPyubXBqLYSt2CbUfhJx3olQ1IRkSZnteXRPePszfV8O2ILJ20vc0TCMAZdtFSAuhn12O9Ip4hKYAQVpOh/mhnelNqQTHg5vXpmls0YKbbXx5MYAAwL1IsTZGS2HUSxWIfKQaPAfjA9B7WXFBPoKwO8pNmw0TDZkr8IHMSKnrcoq+FmccBvswGDVSe3a2xZl9i15YOR1sYHEZwPs/x3wILY2KQD5wRtqDJ/qFyIFuzIMP8brXdYu6Q+R+SSNNKufYMJX7JKKFUWXgeUWFCjrvKg1FAy2kjRqEjcBSoiB7Upc2tZW9WqW/5AvEd0BwRr8WVgHZlwEStG3QCjQyjud1Sl/pUC/lQS3lSEF7EVJ8TLCM9bjTSZa0mHl2dRtlo+9ruT8apbhk2DWzPEFmb/xLVjnrpLXL9/q1zSug35VjvdM9StDCQhSlmo/AZ3ThzHA70TngLM7zNZyYlduTpheR7uAypDjFkRoxQiXMuhhWwpppdg4gLr1ZZ4sy+543LlUFFy5tb66G3F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39850400004)(346002)(366004)(136003)(451199018)(8936002)(83380400001)(66556008)(66476007)(66946007)(8676002)(86362001)(4326008)(6486002)(36756003)(6506007)(6512007)(316002)(478600001)(6916009)(2616005)(966005)(26005)(186003)(44832011)(6666004)(5660300002)(38100700002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEo3cHAzWm9BeHV4NEttTm51TTFZZWxvRWhtQWsvTGtMNWpRMU14OXFUTzYx?=
 =?utf-8?B?OExLcU03RzNpaFR6a214ekdlanJoWDRZVEtWWHpnaFkraVRiVExlNjJPUysr?=
 =?utf-8?B?ZHdTWjJZYXVEcjJtelI4NExzVDRTaG0zUFl3SE1QaGM4T3ZOSFRtQXo3Nm5p?=
 =?utf-8?B?L0lzVXI5WVhSdnkyUFVkTi9yc2UzbFQvb3ZKS3d5TVNyUzJvTmFqUzRRcWpj?=
 =?utf-8?B?YlQxUTZINHJFVGhQbWtCOW9XalpDVFFhaXlwbTRxSk9qSW1keXR1QTI3QStI?=
 =?utf-8?B?V0pwNlg1elJKREYrYnhpaS9pck5zczF5TmhaTWpjWktXU3BpZFltWnlMZWgr?=
 =?utf-8?B?KzdaTTBZTnVJeEJmb1U4enl0TEsxOE1GQ1dLazNBR2p5MStJcVQ5bnZ1bDFy?=
 =?utf-8?B?aEZ0N2s0ejFXTFg2VDBOUll3Mm9kaWJJaVFMSUluSi9JOWIxeFRuelVjQ1Zt?=
 =?utf-8?B?UDFPczRlTzJ2RW13elZWbWRKdndsRlhocDg2cDc2YmZyVkVGMTkwK1R4czlE?=
 =?utf-8?B?VFhia0xOeW5ZKytvdnlIVTE3ZUtSQndmbnREcXlnR1B0SUlDdkk0KzBFRlU0?=
 =?utf-8?B?THVSL2lsaThxU2xpMk93OVNRTmZsVjgzZ1dLK1hrakhRT2E3SDJLaHV1QmY4?=
 =?utf-8?B?Q005OXpDUWNZYlMvamdjSzdMY0RYaklPc3lONnZINVk1MWdFOWs4R3haTDBO?=
 =?utf-8?B?SmNPNHh5TE8zR0FWZzhLdHJFdEtsY3dMM0xJdk1UVFNQRWlSSU04bXlxL21F?=
 =?utf-8?B?NUtZcFNRQjQvbXQvZndsUW95ODJtS0xRb3Bncy9sZUJTS3plb3RIdjNDSHFx?=
 =?utf-8?B?dWhVbVZOSVpxU2F0bUozbVFpNnNXNCt5Qmhzc0J6UmIydnYxdExMTkcxU2Ni?=
 =?utf-8?B?MUZHK3lSZlQ4ektnK2x3UGJHYWkzVE5qWHc4VC90MHlFOGJOeEpST2ZIVWdW?=
 =?utf-8?B?NWlRZXZxOWxDbGM4MmNLczAvOVB6TUFjSUphendwcDBQZHJnMXQ1RkhCUnVV?=
 =?utf-8?B?Y2FhVUNnVHA3b3JrTmNHMXZITEhUZ0ozOGFZVVFLbUhTblU0Q1hwT09YS2VS?=
 =?utf-8?B?cklZVjBkK2s3aEVQL2JXalhYdXMwSzhuN0QvTVk5RmVEdXV5NmtZYWJkY1I1?=
 =?utf-8?B?Z3o4VkF5NEs0dTFId2FuR1lQaWYzcWkvRFZHVCsvODltdi9xZGkyYnRiblZk?=
 =?utf-8?B?Um9VQXJSY3E0cEgzN3FJRDYvVm5iTHBaQ3EySU5mOGw2bC92UGNIalQxcTNW?=
 =?utf-8?B?UC9ydm03aW5mQXY3WjdtK3hrekdsU2sySHBBclhuSXFiU1k2dEVlVmg0aWJw?=
 =?utf-8?B?VTRxOGFrUDgrVzdkOXRwRnJKWFl1VjVQakp0WVFRNXZrUFAwT2k4cjd2enQ4?=
 =?utf-8?B?SVhKZ281SU5pNHRYYUtUWHBGUjZ3aENTcERieUI4N1BZKzRBWXdMSXZyYVBW?=
 =?utf-8?B?U0p4QjUzRTdhQklKYjlNMEVWaVFiTi9aOVJBU0hzNTg2Y0c3ajhmM1JwVU9O?=
 =?utf-8?B?ZjhaMzQxZDRSUS9Sb1lWV1RVd1cwcUZJQmI0WUg0MjUyVVZiVk96Ti9OYlN5?=
 =?utf-8?B?NnZEUUYzNzB3Z3d2Ykt0NzIvQVo3a21hQmUyTVpBcUs0U2VYUXRZMDBINGNE?=
 =?utf-8?B?eGhTSld5VldUZUpQYTJMc3o4cTAvWkxYa3BQRDBWeXJwNVAyNVpBMnZ2ZHRw?=
 =?utf-8?B?MnBvUVluZnNWSDFKcXhaWkJiRHpkWDNsVGxPUzZnRVRZbEpoQkVicDVDbzBE?=
 =?utf-8?B?Ym9TeWVqS3FHK05NUldGeE5TR0NWZEtKcWxaR0tjTG1DS1lRY1hOMXZMMVJq?=
 =?utf-8?B?bGdFZUFPT2FPRXhrSWxmaVl1dkpZUWh1S0Y1WEcxQ1pCMmdWQ2ovOFBaMUxs?=
 =?utf-8?B?SlJCanh1bmhZQlpkajIzSmVjZVdLaVY1Wnd3VEsza0loVThLTWNmZU9XaGNB?=
 =?utf-8?B?V0lsdHM4ckNPM1ZiQXR6SjFaT2h3WW8wRmZGano2aFlMOE1ETm4rSEd3UHpp?=
 =?utf-8?B?RjllelNCdWl1b2kxT0lyaUtZRE01UmwxampzeG5jMW9pT1hCcWNkVWR4blor?=
 =?utf-8?B?dUo5SU9wYVZVaDFaWkQyWEpVOXdMUjdYbThXRGZNN3BvRXpFaXk4T1p1Nmha?=
 =?utf-8?B?TlYraGZNUTdkVGZFZ3RxWUhLTjAyUWVCb3R4dk9OTDd2bVdSc1JPNnRVM1hT?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddd39ef-3d12-4b3c-5c0e-08daffe981df
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 22:05:59.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuQ1zJXiLv1Bsvn9KjnhexpcImHqwWStRnbgHI00fS9BbqtGFWmnwhFt++JyekyTEViJcTW6/b5KY38jWgtwGqc+6t1zcgz1moKsZ+oURiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR17MB6874
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 25, 2023 at 10:25:42PM -0800, Dan Williams wrote:
> There are still some sharp edges on this patchset, like the missing
> device-dax hookup, but it is likely enough to show the direction and
> unblock other testing. Specifically I want to see how this fares with
> Greg's recent volatile region provisioning in QEMU.
> 
> I am hoping to have those last bits ironed out before the end of the
> week. Note that this topic branch will rebase so do not base any
> work beyond proof-of-concept on top of it.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region


Testing this out now.  Pulled it on top of the recent DOE updates so
this build error may be related (or not).  But it does look like it's
just a naming collision.




lib/stackinit_kunit.c:34:13: error: conflicting types for ‘range_contains’; have ‘bool(char *, size_t,  char *, size_t)’ {aka ‘_Bool(char *, long unsigned int,  char *, long unsigned int)’}
   34 | static bool range_contains(char *haystack_start, size_t haystack_size,
      |             ^~~~~~~~~~~~~~
In file included from ./arch/x86/include/asm/page.h:21,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:9,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/kref.h:16,
                 from ./include/kunit/test.h:21,
                 from lib/stackinit_kunit.c:14:
./include/linux/range.h:16:20: note: previous definition of ‘range_contains’ with type ‘bool(struct range *, struct range *)’ {aka ‘_Bool(struct range *, struct range *)’}
   16 | static inline bool range_contains(struct range *r1, struct range *r2)
      |


Was just going recommend renaming contains to envelops for a quick hack
to fix the build issue.

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 62d5bafd02d1..f781e46a825e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -230,7 +230,7 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
        if (!(cxld->flags & CXL_DECODER_F_RAM))
                return 0;

-       return range_contains(&cxld->hpa_range, dev_range);
+       return range_envelops(&cxld->hpa_range, dev_range);
 }

 static void disable_hdm(void *_cxlhdm)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 73d4d451386b..c0cb828b86e3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1381,7 +1381,7 @@ static int decoder_match_range(struct device *dev, void *data)
                return 0;

        cxlsd = to_cxl_switch_decoder(dev);
-       return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
+       return range_envelops(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
 }

 static void find_positions(const struct cxl_switch_decoder *cxlsd,
@@ -2350,7 +2350,7 @@ static int match_decoder_by_range(struct device *dev, void *data)

        cxlrd = to_cxl_root_decoder(dev);
        r1 = &cxlrd->cxlsd.cxld.hpa_range;
-       return range_contains(r1, r2);
+       return range_envelops(r1, r2);
 }

 static int match_region_by_range(struct device *dev, void *data)
diff --git a/include/linux/range.h b/include/linux/range.h
index 7efb6a9b069b..8ad8c036d027 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -13,7 +13,7 @@ static inline u64 range_len(const struct range *range)
        return range->end - range->start + 1;
 }

-static inline bool range_contains(struct range *r1, struct range *r2)
+static inline bool range_envelops(struct range *r1, struct range *r2)
 {
        return r1->start <= r2->start && r1->end >= r2->end;
 }
