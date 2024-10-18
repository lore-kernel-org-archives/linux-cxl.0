Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8B206E79;
	Fri, 18 Oct 2024 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280796; cv=none; b=tDQlZgx4ac4jBl0RWyCBgzITC4ee5ITFjeHdB8HOiTsjoYUrR9nrIVlL39ogKCpt1NnYwEHVZW7zIM8bUkOfgEnymq8eU11ltjW6wdmUJmzeOKns5o9ceF5TWvClG7hVkyUO6XqijNyLNGkKh+TXeGkNe5L/8Lx4dOw1yoPFoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280796; c=relaxed/simple;
	bh=3JfD/IY0gogMnjuoL9D2GLfZIVy1JrKKP7OgwHv7vxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDaErFJL4blm56hSxVSZMo1tJfDdVwe+XVc9BekFyp4iLFJiZ0eA4++9NVi1gjPG+UbiDwhAaIlkiRTCQf+jAgwBFK2OxogAfw3AZHmSYtgT/IyvEf380j89NwwKX13Qn1TSF5dkFTfMVOp6K5YZRCihsbirxq0yJpivuNbG1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdH9rCRT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdH9rCRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729280794; x=1760816794;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3JfD/IY0gogMnjuoL9D2GLfZIVy1JrKKP7OgwHv7vxc=;
  b=kdH9rCRTO/XqyBjoClDXNZysO+Qzybzg+2qIwEf8OjqyDoT2dKlOHvbE
   LgfsS24n9UfzlaTLQzM7V9tTfb+Yfew+w+rIabIag+7PyX2oktUFs2LDb
   8cRi/inSy1/gYxBE/0mE2Y7T3Q9+yx/sbSVwzcRavZC8K5JCXstUacEmL
   YftVeMlze9edBh2nGk9uvcl2gKzr6FYK6a6mM0FgzTDMS7z7nJSceEWU2
   kLKf1Q/6OQ2FhMLVHYxnxREPoEiYdRYcGp0Nilkwc1JUlp0M4QT5EZJu/
   O+y+zQK/H0GDJOft1IMHkqy17TNJdVT1UXP2pCeavstztyawND3C7t78F
   g==;
X-CSE-ConnectionGUID: qP1eZmGETqyj8ztITtzC1Q==
X-CSE-MsgGUID: FK/7LuH4Tyya3ob1UWegkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28704458"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28704458"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:33 -0700
X-CSE-ConnectionGUID: vIC43TlMTTy+WN58dTjGmg==
X-CSE-MsgGUID: i6ikMtlSRtWVSGV1UgTgDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79017578"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.109.148])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:32 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 18 Oct 2024 14:46:25 -0500
Subject: [PATCH 2/3] printf: Add print format (%pra) for struct range
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
In-Reply-To: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729280784; l=7710;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=3JfD/IY0gogMnjuoL9D2GLfZIVy1JrKKP7OgwHv7vxc=;
 b=C7e4ofwLZmWqXfjvO1KoJnpVlBhnDe2j5+Ru7sVlECe5yt+qRTunxNvxUgHvuGG7Fsn/8AV6U
 Wl8nn34ZSxaA2tFUDAupRUR9QS/ZHdDDzDUea2nx0wSxz8iOSFoGgso
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The use of struct range in the CXL subsystem is growing.  In particular,
the addition of Dynamic Capacity devices uses struct range in a number
of places which are reported in debug and error messages.

To wit requiring the printing of the start/end fields in each print
became cumbersome.  Dan Williams mentions in [1] that it might be time
to have a print specifier for struct range similar to struct resource

A few alternatives were considered including '%par', '%r', and '%pn'.
%pra follows that struct range is similar to struct resource (%p[rR])
but needs to be different.  Based on discussions with Petr and Andy
'%pra' was chosen.[2]

Andy also suggested to keep the range prints similar to struct resource
though combined code.  Add hex_range() to handle printing for both
pointer types.

Finally introduce DEFINE_RANGE() as a parallel to DEFINE_RES_*() and use
it in the tests.

Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Link: https://lore.kernel.org/all/66cea3bf3332f_f937b29424@iweiny-mobl.notmuch/ [2]
Suggested-by: "Dan Williams" <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: split from CXL patch set]
[Andy: Define DEFINE_RANGE()]
[Andy: rework hex_range() logic]
[Andy: Don't use fallthrough]
[Andy: clean up help comment]
[Fan: clean up printk comment]
[Rasmus: fix buf processing in hex_range()]
[Rasmus: simplify buffer sizing]
[Rasmus: add '[' to string]
[Bagas: Clarify the start == end print behavior]
---
 Documentation/core-api/printk-formats.rst | 13 +++++++
 include/linux/range.h                     |  6 ++++
 lib/test_printf.c                         | 17 +++++++++
 lib/vsprintf.c                            | 57 +++++++++++++++++++++++++++----
 4 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 14e093da3ccd..e1ebf0376154 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -231,6 +231,19 @@ width of the CPU data path.
 
 Passed by reference.
 
+Struct Range
+------------
+
+::
+
+	%pra    [range 0x0000000060000000-0x000000006fffffff]
+	%pra    [range 0x0000000060000000]
+
+For printing struct range.  struct range holds an arbitrary range of u64
+values.  If start is equal to end only print the start value.
+
+Passed by reference.
+
 DMA address types dma_addr_t
 ----------------------------
 
diff --git a/include/linux/range.h b/include/linux/range.h
index 6ad0b73cb7ad..1358d4b1807a 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -31,4 +31,10 @@ int clean_sort_range(struct range *range, int az);
 
 void sort_range(struct range *range, int nr_range);
 
+#define DEFINE_RANGE(_start, _end)		\
+(struct range) {				\
+		.start = (_start),		\
+		.end = (_end),			\
+	}
+
 #endif
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 5afdf5efc627..59dbe4f9a4cb 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -432,6 +432,22 @@ struct_resource(void)
 	     "%pR", &test_resource);
 }
 
+static void __init
+struct_range(void)
+{
+	struct range test_range = DEFINE_RANGE(0xc0ffee00ba5eba11,
+					       0xc0ffee00ba5eba11);
+	test("[range 0xc0ffee00ba5eba11]", "%pra", &test_range);
+
+	test_range = DEFINE_RANGE(0xc0ffee, 0xba5eba11);
+	test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
+	     "%pra", &test_range);
+
+	test_range = DEFINE_RANGE(0xba5eba11, 0xc0ffee);
+	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",
+	     "%pra", &test_range);
+}
+
 static void __init
 addr(void)
 {
@@ -807,6 +823,7 @@ test_pointer(void)
 	symbol_ptr();
 	kernel_ptr();
 	struct_resource();
+	struct_range();
 	addr();
 	escaped_str();
 	hex_string();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 09f022ba1c05..f6a62f273fad 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1039,6 +1039,20 @@ static const struct printf_spec default_dec04_spec = {
 	.flags = ZEROPAD,
 };
 
+static noinline_for_stack
+char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
+		struct printf_spec spec)
+{
+	buf = number(buf, end, start_val, spec);
+	if (start_val == end_val)
+		return buf;
+
+	if (buf < end)
+		*buf = '-';
+	++buf;
+	return number(buf, end, end_val, spec);
+}
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
 		      struct printf_spec spec, const char *fmt)
@@ -1115,11 +1129,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		p = string_nocheck(p, pend, "size ", str_spec);
 		p = number(p, pend, resource_size(res), *specp);
 	} else {
-		p = number(p, pend, res->start, *specp);
-		if (res->start != res->end) {
-			*p++ = '-';
-			p = number(p, pend, res->end, *specp);
-		}
+		p = hex_range(p, pend, res->start, res->end, *specp);
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
@@ -1140,6 +1150,31 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	return string_nocheck(buf, end, sym, spec);
 }
 
+static noinline_for_stack
+char *range_string(char *buf, char *end, const struct range *range,
+		   struct printf_spec spec, const char *fmt)
+{
+	char sym[sizeof("[range 0x0123456789abcdef-0x0123456789abcdef]")];
+	char *p = sym, *pend = sym + sizeof(sym);
+
+	struct printf_spec range_spec = {
+		.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * 8 */
+		.flags = SPECIAL | SMALL | ZEROPAD,
+		.base = 16,
+		.precision = -1,
+	};
+
+	if (check_pointer(&buf, end, range, spec))
+		return buf;
+
+	p = string_nocheck(p, pend, "[range ", default_str_spec);
+	p = hex_range(p, pend, range->start, range->end, range_spec);
+	*p++ = ']';
+	*p = '\0';
+
+	return string_nocheck(buf, end, sym, spec);
+}
+
 static noinline_for_stack
 char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		 const char *fmt)
@@ -2229,6 +2264,15 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+static noinline_for_stack
+char *resource_and_range(const char *fmt, char *buf, char *end, void *ptr,
+			 struct printf_spec spec)
+{
+	if (*fmt == 'r' && fmt[1] == 'a')
+		return range_string(buf, end, ptr, spec, fmt);
+	return resource_string(buf, end, ptr, spec, fmt);
+}
+
 int __init no_hash_pointers_enable(char *str)
 {
 	if (no_hash_pointers)
@@ -2277,6 +2321,7 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  * - 'Bb' as above with module build ID (for use in backtraces)
  * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
  * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
+ * - 'ra' For struct ranges, e.g., [range 0x0000000000000000 - 0x00000000000000ff]
  * - 'b[l]' For a bitmap, the number of bits is determined by the field
  *       width which must be explicitly specified either as part of the
  *       format string '%32b[l]' or through '%*b[l]', [l] selects
@@ -2401,7 +2446,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return symbol_string(buf, end, ptr, spec, fmt);
 	case 'R':
 	case 'r':
-		return resource_string(buf, end, ptr, spec, fmt);
+		return resource_and_range(fmt, buf, end, ptr, spec);
 	case 'h':
 		return hex_string(buf, end, ptr, spec, fmt);
 	case 'b':

-- 
2.47.0

