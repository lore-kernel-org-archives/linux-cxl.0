Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3062CD4F2B
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 08:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjIVItr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjIVItj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 04:49:39 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F286BBB
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 01:49:30 -0700 (PDT)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnioWVQ1lO6oLAw--.14491S2;
        Fri, 22 Sep 2023 16:49:26 +0800 (CST)
Received: from WYQ-S (unknown [218.76.62.144])
        by mail (Coremail) with SMTP id AQAAfwCXrnoSVQ1lREAAAA--.279S3;
        Fri, 22 Sep 2023 16:49:22 +0800 (CST)
Date:   Fri, 22 Sep 2023 16:49:23 +0800
From:   "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To:     linux-cxl <linux-cxl@vger.kernel.org>
Subject: Re: A confusion about cxl.mem in CXL drivers
References: <2023082215220191352877@phytium.com.cn>, 
        <2023092018244461102314@phytium.com.cn>, 
        <20230920131902.0000504f@Huawei.com>
X-Priority: 3
X-GUID: 184AB308-2406-4B27-A97A-E7ECB9AAE522
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.228[cn]
Mime-Version: 1.0
Message-ID: <2023092216492261309286@phytium.com.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID: AQAAfwCXrnoSVQ1lREAAAA--.279S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAKAWUMlaoBGAALsO
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
        1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF1DWF1rGrWktr4UZF45GFg_yoW8XFyUpF
        WxKrs8WFWkCF4xAa18JF47Zry3JwnrJay3Gwn5JFZ3Ar4rCFyjgF4kWr1jgw47Xr4kKw1U
        XF1DXrW5CF4kZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T27CoDIwMjMtMDktMjDCoDIwOjE5LMKgwqBqb25hdGhhbi5jYW1lcm9uwqB3cm90ZToKClRoYW5r
c8KgZm9ywqB5b3VywqBwYXRpZW50wqBleHBsYW5hdGlvbi4KCj4KPsKgU2/CoGZyb23CoGRyaXZl
csKgc2lkZcKgb2bCoHRoaW5ncyzCoHRoZcKgQ1hMLklPwqBzdHVmZsKgaXPCoGVpdGhlcsKgaW7C
oEVDQU3CoChmb3LCoGNvbmZpZwo+wqBzcGFjZSnCoG9ywqBtYXBwZWTCoGFzwqBQQ0llwqBCQVJz
LsKgwqBUaGXCoENYTC5tZW3CoHN0dWZmwqBpc8KgbWFwcGVkwqB2aWHCoHRoZcKgSG9zdMKgUGh5
c2ljYWwKPsKgQWRkcmVzc2VzwqBkZXNjcmliZWTCoGluwqBhwqBDWEzCoEZpeGVkwqBNZW1vcnnC
oFdpbmRvdy4KPsKgCj7CoFNvwqB0aGXCoHJpZ2h0wqB0eXBlwqBvZsKgYWNjZXNzwqBpc8KgdXNl
ZMKgYmFzZWTCoG9uwqB0aGXCoHVuZGVybHlpbmfCoGhhcmR3YXJlwqBwZXJmb3JtaW5nCj7CoHRo
ZcKgcm91dGluZ8KgZm9ywqB0aGXCoGFwcHJvcHJpYXRlwqBIb3N0wqBQaHlzaWNhbMKgQWRkcmVz
c8KgcmFuZ2UuwqDCoFNhbWXCoGFwcGxpZXMKPsKgb27CoHRvcMKgb2bCoFFFTVUuCj7CoAoKVGhl
cmVmb3JlLMKgZnJvbcKgdGhlwqB2aWV3wqBvZsKga2VybmVswqBzaWRlLMKgdGhlwqBrZXJuZWzC
oGRvwqBub3TCoG5lZWTCoHRvwqBkaXN0aW5ndWlzaMKgdGhlwqBwaHlzaWNhbMKgY3hswqBzdWJw
cm90b2NvbAooY3hsLmlvLGN4bC5jYWNoZSxjeGwubWVtKS7CoEluwqBmYWN0LMKgdGhlwqB1bmRl
cmx5aW5nwqBoYXJkd2FyZcKgd291bGTCoGRpcmVjdGx5wqBmaW5pc2jCoHRoaXPCoHdvcmvCoHNv
wqBzeXN0ZW3CoHNvZnR3YXJlCmRvbid0wqBjYXJlwqBhYm91dMKgaXQuCgpBY2NvcmRpbmfCoHRv
wqB0aGXCoGluc3RhbmNlwqBvZsKgcWVtdcKgdmlydMKgbWFjaGluZSzCoG15wqB1bmRlcnN0YW5k
aW5nwqBpc8KgYmVsb3c6CjEpwqBDWEwuSU86wqBmaW5kaW5nLMKgc2V0dGluZ8KgYW5kwqBlbnVt
ZXJhdGluZ8KgQ1hMwqBFQ0FNL0JBUnPCoChwcm9ncmFtbWVkwqBpbsKgY3hsX2FjcGkswqBjeGxf
cGNpwqBkcml2ZXJzKQrCoMKgwqDCoFVuZGVybHlpbmfCoGhhcmR3YXJlwqBwZXJmb3JtaW5nwqB0
aGXCoHJvdXRpbmfCoDrCoFBDSWXCoFJDCsKgwqDCoMKgCjIpwqBDWEwuTUVNOsKgaG9zdMKgaXPC
oGdvaW5nwqB0b8KgYWNjZXNzwqB0aGXCoG1lbW9yecKgbWFwcGVkwqBpbsKgQ0ZNV3PCoArCoMKg
wqDCoFVuZGVybHlpbmfCoGhhcmR3YXJlwqBwZXJmb3JtaW5nwqB0aGXCoHJvdXRpbmfCoDrCoEhE
TcKgZGVjb2RlcnMKCk1hbnnCoHRoYW5rcwpZdXF1YW4=

